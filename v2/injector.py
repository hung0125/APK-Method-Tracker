import os.path
from os import walk
from os.path import dirname, basename
from pathlib import Path
from time import time
from shutil import copy
from urllib.parse import urlparse

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
        elif len(components) == 3 and '->setText(' in code[i]:
            cnt_setText += 1 
    
    return f'{cnt_hardcode},{cnt_boolean},{cnt_array},{cnt_setText},{cnt_url}'

def inject(pth):
    cont = open(pth, 'rb').read().decode('utf-8').splitlines()
    mod_cont = []

    header = cont[0].split()
    cur_class = header[-1].replace(';', '')
    read_method = ''
    read_local = False
    for i, L in enumerate(cont):
        mod_cont.append(L)

        if L.startswith('.method ') and not ' abstract ' in L:
            read_method = L

        elif read_method and L.strip().startswith('.locals') or L.strip().startswith('.registers'):
            read_local = True
            if ' 0' in L:
                mod_cont[-1] = mod_cont[-1].replace('0', '1')
            
            meth_name = read_method.split(' ')[-1]

            # https://groups.google.com/g/apktool/c/Elvhn32HvJQ
            mod_cont.append(f'const-string v0, "{cur_class}->{meth_name}::{static_analysis(i, cont)}"')
            mod_cont.append('invoke-static {v0}, Ltrace/MethodTrace;->writeTrace(Ljava/lang/String;)V')

        elif read_method and read_local:
            read_method = ''
            read_local = False
    
    open(pth,'wb').write('\n'.join(mod_cont).encode('utf-8'))

# base_dir: the base directory of the decompiled folder
# base_dir: do not include ending slashes
# what to do: configure the base directory > insert MethodTrace.smali to 'smali\trace\' (create the path manually) > run this script 
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
        inject(F)

#TODO: path handling