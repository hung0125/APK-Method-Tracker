from os import walk
import os.path
import re
from tqdm import tqdm

def find_uitext_calls(smali):
    cont = open(smali, 'rb').read().decode('utf-8').splitlines()
    cnt = 0
    pattern = r'\{(.*?)\}(.*)?\((.*?)\)'
    for L in cont:
        if L.strip().startswith('invoke-'):
            call = re.search(pattern, L.strip()).group(2)
            if call.startswith(', Landroid/widget/'):
                cnt += 1

    return cnt

def precheck_isActivity(smali) -> bool:
    cont = open(smali, 'rb').read().decode('utf-8').splitlines()
    for L in cont:
        if L.startswith('.method ') and L.endswith(' onCreate(Landroid/os/Bundle;)V'):
            return True
    
    return False


def get_smali_files(dir_path):
    sorted_path = []
    upaths = {}
    is_activity = {}
    for root, dirs, files in walk(dir_path):
        base_path = root[len(dir_path)+1:]
        for file in tqdm(files):
            if file.endswith(".smali"):
                smali_path = os.path.join(root, file)
                
                if not base_path in is_activity and precheck_isActivity(smali_path):
                    is_activity[base_path] = True
                
                if not base_path in upaths:
                    upaths[base_path] = True
                    sorted_path.append(base_path)
                
                
    return [sorted_path, is_activity]

base = input('input decompiled base path: ')

result = get_smali_files(base)
roots = result[0]
check_activity_class = result[1]

if os.path.isfile('libkeep.txt'):
    os.remove('libkeep.txt')

open('libkeep.txt', 'ab').write('# Injector.py will only inject to the smali files that are contained in any of the following paths\n'.encode('utf-8'))

outstr_important = []
outstr_general = []
for R in roots:
    print(R)
    if R in check_activity_class:
        outstr_important.append(str(f'!ACTIVITY_CLASS!->{R}' + '\n').encode('utf-8'))
    else:
        outstr_general.append(str(f'!GENERAL!->{R}' + '\n').encode('utf-8'))

for L in outstr_important:
    open('libkeep.txt', 'ab').write(L)
for L in outstr_general:
    open('libkeep.txt', 'ab').write(L)