import os.path
import re
from tqdm import tqdm
from os import walk
from os.path import dirname
from pathlib import Path
from time import time
from shutil import copy, copytree
from random import choice as cc

name_list = '''習近平
溫家寶
李克強
王毅
秦剛
華春瑩
陸慷
耿爽
趙立堅
你媽'''.splitlines()


def get_smali_files(dir_path):
    smali_files = []
    for root, dirs, files in walk(dir_path):
        for file in files:
            if file.endswith(".smali"):
                smali_files.append(os.path.join(root, file))
    return smali_files

def split_param(string):
    array = []
    in_array = False
    in_lib = False
    lib_name = 'L'
    for c in string:
        if not in_array and c == '[':
            in_array = True
        elif not in_lib and c == 'L':
            in_lib = True
        elif c == ';':
            if in_array:
                lib_name = '[' + lib_name
                in_array = False
            array.append(lib_name)
            lib_name = 'L'
            in_lib = False
        else:
            if in_lib:
                lib_name += c
            elif in_array: 
                array.append('[' + c)
                in_array = False
            else:
                array.append(c)

    return array
    
def static_analysis(lineIdx, code):
    cnt_hardcode = 0
    cnt_boolean = 0
    cnt_array = 0
    cnt_setText = 0
    cnt_url = 0
    cnt_mathops = 0

    for i in range(lineIdx, len(code)):
        if code[i] == '.end method':
            break
        
        components = code[i].strip().split(' ')
        
        if len(components) > 2 and components[0] == 'const-string':
            cnt_hardcode += 1
            if 'https://' in code[i] or 'http://' in code[i]:
                cnt_url += 1
        elif len(components) > 2 and 'if-' in components[0]:
            cnt_boolean += 1
        elif len(components) > 2 and components[0] == 'new-array' or components[0] == 'new-instance' and components[2] == 'Ljava/util/ArrayList;':
            cnt_array += 1
        elif len(components) > 2 and '->setText(' in code[i]:
            cnt_setText += 1
        elif len(components) > 2 and ('add-' in components[0] or 'sub-' in components[0] or 'rsub-' in components[0] or 'mul-' in components[0] or 'div-' in components[0] or 'rem-' in components[0]):
            cnt_mathops += 1
    
    return f'{cnt_hardcode},{cnt_boolean},{cnt_array},{cnt_setText},{cnt_url},{cnt_mathops}'

def precheck_ok(lineIdx, code) -> bool:
    for i in range(lineIdx, len(code)):
        if code[i] == '.end method':
            break
        if ' p15' in code[i]:
            return False
        
    return True

def find_registers(line: str) -> list:
    ls = []
    comp = line.strip().split(' ')
    if comp[0] == '#' or comp[0].startswith('invoke-'):
        return ls
    
    try:
        if comp[0] != 'move-result-object':
            comp.pop()
        comp.pop(0)
    except:
        return ls

    for C in comp:
        reg = re.sub(r'[{},./]', '', C)
        if reg.startswith('v') and len(reg) > 1 and reg[1].isdigit():
            ls.append(reg)
    return ls

def inject(pth):
    cont = open(pth, 'rb').read().decode('utf-8').splitlines()
    mod_cont = []

    header = cont[0].split()
    cur_class = header[-1].replace(';', '')
    read_method = ''
    read_local = False
    in_try_block = False
    register_map = {}
    for i, L in enumerate(cont):
        mod_cont.append(L)

        # mark down local registers
        marked_registers = find_registers(L)
        for M in marked_registers:
            register_map[M] = True
        '''
        - if there's p15 and locals = 0, ignore
        - ensure locals >= 1
        - always use v0
        '''
        if L.startswith('.method ') and not ' abstract ' in L and not ' synthetic ' in L:
            read_method = L

        elif read_method and L.strip().startswith('.locals') or L.strip().startswith('.registers'):
            read_local = True

            if ' 0' in L:
                if not precheck_ok(i, cont):
                    continue # skip modification
                mod_cont[-1] = mod_cont[-1].replace(' 0', ' 1')
            
            meth_name = read_method.split(' ')[-1]
            mod_cont.append(f'const-string v0, "{cur_class}->{meth_name}::{static_analysis(i, cont)}"')
            mod_cont.append(f'invoke-static {{v0}}, Ltrace/MethodTrace;->writeTrace(Ljava/lang/String;)V')

        elif read_method and L.strip().startswith(':try_start'):
            in_try_block = True
        elif read_method and in_try_block and L.strip().startswith(':try_end'):
            in_try_block = False
        elif read_method and L.strip().startswith('invoke-static') or L.strip().startswith('invoke-virtual') or L.strip().startswith('invoke-direct') or L.strip().startswith('invoke-interface'):
            if '/range {' in L:
                continue # skip ranged params (very difficult to process...)

            # Regular expression pattern to extract the parameters within ()
            pattern = r'\{(.*?)\}.*?\((.*?)\)'

            # Extracting the parameters
            match = re.search(pattern, L.strip())
            if match:
                registers = match.group(1)  # Extracted registers
                params = match.group(2)     # Extracted parameters

                # Splitting the registers and parameters
                # invoke-virtual/invoke-direct/invoke-interface ==> start from 2nd register
                # invoke-static ==> start from 1st register
                registers = [reg.strip() for reg in registers.split(',')]
                params = split_param(params)
                is_zero_based = L.strip().startswith('invoke-static')
                for j in range(len(params)):
                    target_reg = None
                    if params[j] == 'Ljava/lang/String' or params[j] == '[Ljava/lang/String':
                        valid_cnt = 0
                        for jj in range(0 if is_zero_based else 1, len(registers)):
                            # Assume 'p' always registered, 'v' may not be assigned
                            if registers[jj] in register_map or registers[jj].startswith('p'):
                                valid_cnt += 1
                            if valid_cnt == j+1: # matched the j+1 th valid register
                                target_reg = registers[jj]
                                break

                    if params[j] == 'Ljava/lang/String' and target_reg != None:
                        reg_integer = int(''.join([char for char in target_reg if char.isdigit()]))
                        if reg_integer < 16:
                            mod_cont.insert(-1, f'invoke-static {{{target_reg}}}, Ltrace/MethodTrace;->writeRTData(Ljava/lang/String;)V')
                        else:
                            mod_cont.insert(-1, f'invoke-static/range {{{target_reg} .. {target_reg}}}, Ltrace/MethodTrace;->writeRTData(Ljava/lang/String;)V')
                    elif params[j] == '[Ljava/lang/String' and target_reg != None:
                        reg_integer = int(''.join([char for char in target_reg if char.isdigit()]))
                        if reg_integer < 16:
                            mod_cont.insert(-1, f'invoke-static {{{target_reg}}}, Ltrace/MethodTrace;->writeRTArrayData([Ljava/lang/String;)V')
                        else:
                            mod_cont.insert(-1, f'invoke-static/range {{{target_reg} .. {target_reg}}}, Ltrace/MethodTrace;->writeRTArrayData([Ljava/lang/String;)V')

        elif read_method and L.strip().startswith('const-string'):
            register = L.strip().split(' ')[1][:-1]
            reg_integer = int(''.join([char for char in register if char.isdigit()]))
            if reg_integer < 16:
                mod_cont.append(f'invoke-static {{{register}}}, Ltrace/MethodTrace;->writeRTData(Ljava/lang/String;)V')
            else:
                mod_cont.append(f'invoke-static/range {{{register} .. {register}}}, Ltrace/MethodTrace;->writeRTData(Ljava/lang/String;)V')

        elif read_method and L.strip().startswith('move-result-object'):
            prev_op = ''
            
            for ii in range(-1, -11, -1):
                if len(mod_cont[ii].strip()) > 0:
                    prev_op = mod_cont[ii]
                    break

            register = L.strip().split(' ')[1]
            if in_try_block and register.startswith('p'): # one possible workaround is write dump outside try block, but risky
                continue
            
            if (str) (prev_op).endswith(')Ljava/lang/String;'):
                reg_integer = int(''.join([char for char in register if char.isdigit()]))
                if reg_integer < 16:
                    mod_cont.append(f'invoke-static {{{register}}}, Ltrace/MethodTrace;->writeRTData(Ljava/lang/String;)V')
                else:
                    mod_cont.append(f'invoke-static/range {{{register} .. {register}}}, Ltrace/MethodTrace;->writeRTData(Ljava/lang/String;)V')
            elif (str) (prev_op).endswith(')[Ljava/lang/String;'):
                reg_integer = int(''.join([char for char in register if char.isdigit()]))
                if reg_integer < 16:
                    mod_cont.append(f'invoke-static {{{register}}}, Ltrace/MethodTrace;->writeRTArrayData([Ljava/lang/String;)V')
                else:
                    mod_cont.append(f'invoke-static/range {{{register} .. {register}}}, Ltrace/MethodTrace;->writeRTArrayData([Ljava/lang/String;)V')

        elif read_method and read_local and L == '.end method':
            read_method = ''
            read_local = False
            register_map = {}

    open(pth,'wb').write('\n'.join(mod_cont).encode('utf-8'))

def troll9(pth):
    cont = open(pth, 'rb').read().decode('utf-8').splitlines()
    mod_cont = []

    for i, L in enumerate(cont):
        if i < len(cont) - 1:
            is_textview = cont[i+1].endswith('Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V')
            is_edittext = cont[i+1].endswith('Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V')
            is_button = cont[i+1].endswith('Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V')
            
            if is_textview or is_edittext or is_button:
                reg = cont[i+1].strip().split(' ')[2][:-2]
                mod_cont.append(f'const-string {reg}, "{cc(name_list)}死了!!"')
        
        mod_cont.append(L)
    
    open(pth,'wb').write('\n'.join(mod_cont).encode('utf-8'))

def inject_flow():
    base_dir = input('Specify decompiled base path: ')
    while base_dir[-1] == '/' or base_dir[-1] == '\\':
        base_dir = base_dir[:-1]
    smali_list = get_smali_files(base_dir)
    keep_list = open('libkeep.txt', 'rb').read().decode('utf-8').splitlines()[1:]
    keep_list = dict(zip(keep_list, [True] * len(keep_list)))
    timeNow = int(time())

    for F in tqdm(smali_list):
        if str(Path(F).parent.absolute())[len(base_dir)+1:] in keep_list and not F.endswith('MethodTrace.smali'):
            bkupDir = f"backup_{timeNow}/{dirname(F.replace(base_dir, ''))}"
            Path(bkupDir).mkdir(parents=True, exist_ok = True)
            copy(F, bkupDir)
            inject(F)

    if not os.path.exists(base_dir + '/smali/trace'):
        os.makedirs(base_dir + '/smali/trace')
    copy('MethodTrace.smali', base_dir + '/smali/trace/MethodTrace.smali')

def troll_flow():
    base_dir = input('Specify decompiled base path: ')
    while base_dir[-1] == '/' or base_dir[-1] == '\\':
        base_dir = base_dir[:-1]
    smali_list = get_smali_files(base_dir)
    keep_list = open('libkeep.txt', 'rb').read().decode('utf-8').splitlines()[1:]
    keep_list = dict(zip(keep_list, [True] * len(keep_list)))
    timeNow = int(time())

    for F in smali_list:
        if str(Path(F).parent.absolute())[len(base_dir)+1:] in keep_list and not F.endswith('MethodTrace.smali'):
            print(F)
            bkupDir = f"backup_{timeNow}/{dirname(F.replace(base_dir, ''))}"
            Path(bkupDir).mkdir(parents=True, exist_ok = True)
            copy(F, bkupDir)
            troll9(F)

def restore_flow():
    base_dir = input('Specify decompiled base path: ')
    while base_dir[-1] == '/' or base_dir[-1] == '\\':
        base_dir = base_dir[:-1]
    dir_names = next(os.walk('.'))[1]
    backup_folder = 'backup_0'
    for D in dir_names:
        if len(D.split('_')) == 2 and int(D.split('_')[1]) > int(backup_folder.split('_')[1]):
            backup_folder = D

    copytree(backup_folder, base_dir, dirs_exist_ok=True)

    if os.path.exists(base_dir + '/smali/trace/MethodTrace.smali'):
        os.remove(base_dir + '/smali/trace/MethodTrace.smali')

    if not os.listdir(base_dir + '/smali/trace'):
        os.rmdir(base_dir + '/smali/trace')


while True:
    display = '''
Select a function:
(1) inject
(2) restore latest backup
(3) insert permission (smali only)
(4) troll
'''
    print(display)
    choice = input('> ')
    if choice == '1':
        inject_flow()
    elif choice == '2':
        restore_flow()
    elif choice == '4':
        troll_flow()
