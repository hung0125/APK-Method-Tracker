import os.path
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

def inject(pth):
    cont = open(pth, 'rb').read().decode('utf-8').splitlines()
    mod_cont = []

    header = cont[0].split()
    cur_class = header[-1].replace(';', '')
    read_method = ''
    read_local = False
    for i, L in enumerate(cont):
        mod_cont.append(L)
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
                    continue
                mod_cont[-1] = mod_cont[-1].replace(' 0', ' 1')
            
            meth_name = read_method.split(' ')[-1]
            mod_cont.append(f'const-string v0, "{cur_class}->{meth_name}::{static_analysis(i, cont)}"')
            mod_cont.append(f'invoke-static {{v0}}, Ltrace/MethodTrace;->writeTrace(Ljava/lang/String;)V')

        elif read_method and read_local:
            read_method = ''
            read_local = False
    
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
