from os import walk
import os.path
import re
from tqdm import tqdm

basic_class_filters = [
    'androidx\\',
    'android\\support\\',
    'com\\google\\',
    'com\\android\\',
    'com\\fasterxml\\',
    'io\\reactivex\\',
    'kotlin\\'
]

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

def precheck_isActivity(smali_cont: str) -> bool:
    cont = smali_cont.splitlines()
    for L in cont:
        if L.startswith('.method ') and L.endswith(' onCreate(Landroid/os/Bundle;)V'):
            return True
    
    return False

def precheck_useInternalHttpLib(smali_cont: str) -> bool:
    keywords = ['Ljava/net/']
    for K in keywords:
        if K in smali_cont:
            return True
    return False

def get_smali_files(dir_path):
    sorted_path = []
    upaths = {}
    is_activity = {}
    use_internal_http_lib = {}
    for root, dirs, files in walk(dir_path):
        base_path = root[len(dir_path)+1:]
        for file in tqdm(files):
            if file.endswith(".smali"):
                smali_path = os.path.join(root, file)
                smali_cont = None

                if not base_path in is_activity:
                    smali_cont = open(smali_path, 'rb').read().decode('utf-8')
                    if precheck_isActivity(smali_cont):
                        is_activity[base_path] = True 

                if not base_path in upaths:
                    upaths[base_path] = True
                    sorted_path.append(base_path)
                
                if not base_path in use_internal_http_lib:
                    if not smali_cont:
                        smali_cont = open(smali_path, 'rb').read().decode('utf-8')
                    if precheck_useInternalHttpLib(smali_cont):
                        use_internal_http_lib[base_path] = True
                
    return [sorted_path, is_activity, use_internal_http_lib]

base = input('Input decompiled base path: ')

result = get_smali_files(base)
roots = result[0]
check_activity_class = result[1]
check_use_internal_http_lib = result[2]

if os.path.isfile('libkeep.txt'):
    os.remove('libkeep.txt')

open('libkeep.txt', 'ab').write('# Injector.py will only inject to the smali files that are contained in any of the following paths\n'.encode('utf-8'))

outstr_important = []
outstr_general = []
for R in roots:
    print(R)
    
    subpath = re.sub(r'^[^\\]+\\', '', R)
    in_basic_filter = False
    for F in basic_class_filters:
        if subpath.startswith(F):
            in_basic_filter = True
            break
    if in_basic_filter: continue

    if R in check_activity_class:       
        outstr_important.append(str(f'!ACTIVITY_CLASS{"&BUILT_IN_REST" if R in check_use_internal_http_lib else ''}!->{R}' + '\n').encode('utf-8'))
    else:
        outstr_general.append(str(f'!GENERAL{"&BUILT_IN_REST" if R in check_use_internal_http_lib else ''}!->{R}' + '\n').encode('utf-8'))

for L in outstr_important:
    open('libkeep.txt', 'ab').write(L)
for L in outstr_general:
    open('libkeep.txt', 'ab').write(L)
