import os.path
import re
from tqdm import tqdm
from os import walk
from os.path import dirname
from pathlib import Path
from time import time
from shutil import copy, copytree, rmtree
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
    dim_cnt = 0
    in_lib = False
    lib_name = 'L'
    for c in string:
        if c == '[':
            in_array = True
            dim_cnt += 1
        elif not in_lib and c == 'L':
            in_lib = True
        elif c == ';':
            if in_array:
                lib_name = ('[' * dim_cnt) + lib_name
                in_array = False
                dim_cnt = 0
            array.append(lib_name)
            lib_name = 'L'
            in_lib = False
        else:
            if in_lib:
                lib_name += c
            elif in_array: 
                array.append(('[' * dim_cnt) + c)
                in_array = False
                dim_cnt = 0
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

def precheck_isActivity(codelines:list[str]) -> str:
    read_onCreate = False
    for L in codelines:
        if L.startswith('.method ') and L.endswith(' onCreate(Landroid/os/Bundle;)V'):
            read_onCreate = True
        elif read_onCreate and L.strip().startswith('invoke-super') and L.endswith('>onCreate(Landroid/os/Bundle;)V'):
            pattern = r'\{(.*?)\}, (.*)?-.*\((.*?)\)'
            return re.search(pattern, L.strip()).group(2)

    return ''

def inject(pth, log_meth = False, log_data = False, passive_injection = ''):
    cont = open(pth, 'rb').read().decode('utf-8').splitlines()
    mod_cont = []

    header = cont[0].split()
    cur_class = header[-1].replace(';', '')
    read_method = ''
    read_local = False
    read_onPause = False
    everRead_onPause = False
    read_onResume = False
    everRead_onResume = False
    read_activity_class = precheck_isActivity(cont) # returns a super class
    in_try_block = False
    
    for i, L in enumerate(cont):
        mod_cont.append(L)

        '''
        - if there's p15 and locals = 0, ignore
        - ensure locals >= 1
        - always use v0
        '''
        if L.startswith('.method ') and not ' abstract ' in L and not ' synthetic ' in L:
            read_method = L
            if read_activity_class:
                if L.endswith(' onPause()V'):
                    read_onPause = True
                    everRead_onPause = True
                elif L.endswith(' onResume()V'):
                    read_onResume = True
                    everRead_onResume = True

        elif read_method and L.strip().startswith('.locals') or L.strip().startswith('.registers'):
            read_local = True

            if ' 0' in L:
                if not precheck_ok(i, cont):
                    continue # skip modification
                if log_meth:
                    mod_cont[-1] = mod_cont[-1].replace(' 0', ' 1')
            
            if read_onPause:
                mod_cont.append('''
.annotation system Ldalvik/annotation/Signature;
    value = {
        "()V"
    }
.end annotation''')
                mod_cont.append(f"invoke-static {{}}, Ltrace/MethodTrace;->updateOnPause()V")

            elif read_onResume:
                mod_cont.append(f'invoke-static {{}}, Ltrace/MethodTrace;->updateOnResume()V')

            if log_meth:
                meth_name = read_method.split(' ')[-1]
                mod_cont.append(f'const-string v0, "{cur_class}->{meth_name}::{static_analysis(i, cont)}"')
                mod_cont.append(f'invoke-static {{v0}}, Ltrace/MethodTrace;->writeTrace(Ljava/lang/String;)V')

        elif read_method and L.strip().startswith(':try_start'):
            in_try_block = True

        elif read_method and in_try_block and L.strip().startswith(':try_end'):
            in_try_block = False
        
        elif read_method and log_data and L.strip().startswith('invoke-static') or L.strip().startswith('invoke-virtual') or L.strip().startswith('invoke-direct') or L.strip().startswith('invoke-interface'):
            # Regular expression pattern to extract the parameters within ()
            pattern = r'\{(.*?)\}(.*)?\((.*?)\)'

            # Extracting the parameters
            match = re.search(pattern, L.strip())
            if match:
                registers = match.group(1)  # Extracted registers
                invoke = match.group(2)
                params = match.group(3)     # Extracted parameters

                # Splitting the registers and parameters
                # invoke-virtual/invoke-direct/invoke-interface ==> start from 2nd register
                # invoke-static ==> start from 1st register
                registers = [reg.strip() for reg in registers.split(',')]
                if ' .. ' in registers[0]:
                    start_reg = registers[0].split(' .. ')[0]
                    end_reg = registers[0].split(' .. ')[1]
                    
                    # rework on the list
                    if start_reg == end_reg:
                        registers = [start_reg]
                    else:
                        start_num = int(''.join([char for char in start_reg if char.isdigit()])) + 1
                        prefix = start_reg[0]
                        registers = [start_reg]
                        while f'{prefix}{start_num}' != end_reg:
                            registers.append(f'{prefix}{start_num}')
                            start_num += 1
                        registers.append(end_reg)
                
                acc_types = ['Ljava/lang/String', '[Ljava/lang/String', 'Ljava/lang/CharSequence']
                params = split_param(params)
                is_zero_based = L.strip().startswith('invoke-static')
                cur_reg_idx = 0 if is_zero_based else 1
                injects = []
                valid_statement = True
                for j in range(len(params)):
                    target_reg = None
                    # for CharSequence, only accept android UI set text
                    if params[j] == acc_types[0] or params[j] == acc_types[1] or (params[j] == acc_types[2] and invoke.startswith(', Landroid/widget/') and invoke.endswith(';->setText')):
                        try:
                            target_reg = registers[cur_reg_idx]
                        except:
                            valid_statement = False
                            print(f'Skipped one statement in: {pth}')
                            break
                        cur_reg_idx += 1
                    elif params[j] in ['J', 'D']:
                        cur_reg_idx += 2
                    else:
                        cur_reg_idx += 1

                    if target_reg != None:
                        reg_integer = int(''.join([char for char in target_reg if char.isdigit()]))
                        injects.append(f'invoke-static/range {{{target_reg} .. {target_reg}}}, Ltrace/MethodTrace;->writeRTData({params[j]};)V')
                
                if valid_statement:
                    for LN in injects:
                        mod_cont.insert(-1, LN)


        elif read_method and log_data and L.strip().startswith('const-string'):
            register = L.strip().split(' ')[1][:-1]
            reg_integer = int(''.join([char for char in register if char.isdigit()]))
            if reg_integer < 16:
                mod_cont.append(f'invoke-static {{{register}}}, Ltrace/MethodTrace;->writeRTData(Ljava/lang/String;)V')
            else:
                mod_cont.append(f'invoke-static/range {{{register} .. {register}}}, Ltrace/MethodTrace;->writeRTData(Ljava/lang/String;)V')

        elif read_method and log_data and L.strip().startswith('move-result-object'):
            prev_op = ''
            
            for ii in range(-1, -1000, -1):
                try:
                    test_str = mod_cont[ii].strip()
                    if len(test_str) > 0 and test_str.startswith('invoke-'):
                        prev_op = mod_cont[ii]
                        break
                except:
                    continue

            register = L.strip().split(' ')[1]
            if in_try_block and register.startswith('p'): # one possible workaround is write dump outside try block, but risky
                continue
            
            if (str) (prev_op).endswith(')Ljava/lang/String;'):
                reg_integer = int(''.join([char for char in register if char.isdigit()]))
                argtype = 'Ljava/lang/String;'
                if (str) (prev_op)[-20:-18] == ')[':
                    argtype = '[' + argtype
                if reg_integer < 16:
                    mod_cont.append(f'invoke-static {{{register}}}, Ltrace/MethodTrace;->writeRTData({argtype})V')
                else: 
                    mod_cont.append(f'invoke-static/range {{{register} .. {register}}}, Ltrace/MethodTrace;->writeRTData({argtype})V')                                                                                      

        elif read_method and read_local and L == '.end method':
            read_method = ''
            read_local = False
            read_onPause = False
            read_onResume = False

    if read_activity_class and not passive_injection:
        if not everRead_onPause:
            mod_cont.append(f'''.method public onPause()V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {{
            "()V"
        }}
    .end annotation
    invoke-static {{}}, Ltrace/MethodTrace;->updateOnPause()V
    invoke-super {{p0}}, {read_activity_class}->onPause()V
    return-void
.end method''')

        if not everRead_onResume:
            mod_cont.append(f'''.method public onResume()V
    .locals 0
    invoke-static {{}}, Ltrace/MethodTrace;->updateOnResume()V
    invoke-super {{p0}}, {read_activity_class}->onResume()V
    return-void
.end method''')

    open(pth,'wb').write('\n'.join(mod_cont).encode('utf-8'))

def inject_flow(log_meth: bool, log_data: bool):
    base_dir = ''
    while len(base_dir) == 0:
        base_dir = input('Specify decompiled base path: ')
    package_name = ''
    while len(package_name) == 0:
        package_name = input('Specify the package name (e.g, com.xxx.yyy): ').strip()
    chunk_limit = input('If target app usually generates non-alphabet characters, type "y" (default=mainly alphabet): ').lower()
    
    passive_injection = input('Disable onResume/onPause listener injections (try when app crashes)? (y = yes; default = no): ').lower()
    
    while base_dir[-1] == '/' or base_dir[-1] == '\\':
        base_dir = base_dir[:-1]
    smali_list = get_smali_files(base_dir)
    keep_list = open('libkeep.txt', 'rb').read().decode('utf-8').splitlines()[1:]
    keep_list = [element.split("->")[1] for element in keep_list]
    keep_list = dict(zip(keep_list, [True] * len(keep_list)))
    timeNow = int(time())

    for F in tqdm(smali_list):
        if str(Path(F).parent.absolute())[len(base_dir)+1:] in keep_list and not F.endswith('MethodTrace.smali'):
            bkupDir = f"backup_{timeNow}/{dirname(F.replace(base_dir, ''))}"
            Path(bkupDir).mkdir(parents=True, exist_ok = True)
            copy(F, bkupDir)
            inject(F, log_meth, log_data, passive_injection)

    if not os.path.exists(base_dir + '/smali/trace'):
        os.makedirs(base_dir + '/smali/trace')
    copy('MethodTrace.smali', base_dir + '/smali/trace/MethodTrace.smali')
    MethodTrace = open(base_dir + '/smali/trace/MethodTrace.smali', 'rb').read().decode('utf-8')
    # LENGTH_LIMIT_PER_CHUNK: x3d090 -> 2500000 chars * expected ~4 bytes; x7d000 = 512000 chars * expected ~2 bytes; total <= 1MB
    MethodTrace = MethodTrace.replace('@PACKAGE_NAME@', package_name).replace('@LENGTH_LIMIT_PER_CHUNK@', '3d090' if chunk_limit == 'y' else '7d000')
    open(base_dir + '/smali/trace/MethodTrace.smali', 'wb').write(MethodTrace.encode('utf-8'))

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


def clear_backup():
    current_directory = os.getcwd()

    for item in os.listdir(current_directory):
        item_path = os.path.join(current_directory, item)
        if os.path.isdir(item_path) and item.startswith("backup_"):
            print(f"Deleting folder: {item_path}")
            rmtree(item_path)

while True:
    display = '''
Select a function:
(1) inject (don't use this)
(2) inject method calls only (unlikely to be developed, not useful)
(3) inject runtime data log only
(4) restore latest backup
(5) clear recent backup
'''
    print(display)
    choice = input('> ')
    if choice == '1':
        inject_flow(True, True)
    elif choice == '2':
        inject_flow(True, False)
    elif choice == '3':
        inject_flow(False, True)
    elif choice == '4':
        restore_flow()
    elif choice == '5':
        clear_backup()
