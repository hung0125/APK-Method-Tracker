import os.path
from os import walk
from os.path import dirname
from pathlib import Path
from time import time
from shutil import copy

def get_smali_files(dir_path):
    smali_files = []
    for root, dirs, files in walk(dir_path):
        for file in files:
            if file.endswith(".smali"):
                smali_files.append(os.path.join(root, file))
    return smali_files

def methOk(filLs, s):
    if len(filLs) == 0:
        return True
    else:
        for F in filLs:
                if s.endswith(F):
                    return True
                
    return False

def inject(pth):
    cont = open(pth, 'rb').read().decode('utf-8').splitlines()
    mod_cont = []

    header = cont[0].split()
    cur_class = header[-1].replace(';', '')
    read_method = ''
    read_local = False
    for L in cont:
        mod_cont.append(L)

        if L.startswith('.method ') and not ' abstract ' in L:
            read_method = L

        elif L.strip().startswith('.locals') or L.strip().startswith('.registers'):
            read_local = True
            if ' 0' in L:
                mod_cont[-1] = mod_cont[-1].replace('0', '1')
            
            meth_name = read_method.split(' ')[-1]            

            # https://groups.google.com/g/apktool/c/Elvhn32HvJQ
            mod_cont.append(f'const-string v0, "{cur_class}->{meth_name}"')
            mod_cont.append('invoke-static {v0}, Ltrace/MethodTrace;->writeTrace(Ljava/lang/String;)V')

        elif read_method and read_local:
            read_method = ''
            read_local = False
    
    open(pth,'wb').write('\n'.join(mod_cont).encode('utf-8'))

# base_dir: the base directory of the decompiled folder
# base_dir: do not include ending slashes
# what to do: configure the base directory > insert MethodTrace.smali to 'smali\trace\' (create the path manually) > run this script 
base_dir = input('Specify decompiled base path: ')
smali_list = get_smali_files(base_dir)
keep_list = open('libkeep.txt', 'rb').read().decode('utf-8').splitlines()[1:]
keep_list = dict(zip(keep_list, [True] * len(keep_list)))
timeNow = int(time())

for F in smali_list:
    bkupDir = f"backup_{timeNow}/{dirname(F.replace(base_dir, ''))}"
    Path(bkupDir).mkdir(parents=True, exist_ok = True)
    print(F)
    if not F.endswith('MethodTrace.smali') and F[len(base_dir)+1:] in keep_list:
        copy(F, bkupDir)
        inject(F)

#TODO: path handling