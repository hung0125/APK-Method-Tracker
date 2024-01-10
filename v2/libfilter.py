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

def get_smali_files(dir_path):
    sorted_path = []
    stats = {}
    for root, dirs, files in walk(dir_path):
        base_path = root[len(dir_path)+1:]
        print(base_path)
        for file in tqdm(files):
            if file.endswith(".smali"):
                smali_path = os.path.join(root, file)
                
                if base_path in stats:
                    stats[base_path] += find_uitext_calls(smali_path)
                else:
                    stats[base_path] = find_uitext_calls(smali_path)
                    sorted_path.append(base_path)
                
    return [sorted_path, stats]

base = input('input decompiled base path: ')
scan_option = input('modify what? [1] Everything [2] Involved frontend only [3] Involved logic only: ')
if not scan_option in ['1', '2', '3']:
    print("Invalid option.")
    exit(1)

result = get_smali_files(base)
all_smali_paths = result[0]
roots = []

for F in all_smali_paths:
    roots.append({'path': F, 'uitext_calls': result[1][F]})

if os.path.isfile('libkeep.txt'):
    os.remove('libkeep.txt')

open('libkeep.txt', 'ab').write('# Injector.py will only inject to the smali files that are contained in any of the following paths\n'.encode('utf-8'))

for R in roots:
    print(R)
if scan_option == '1':
    for R in roots:
        open('libkeep.txt', 'ab').write(str(f'Native UI calls: {'NO' if R['uitext_calls'] == 0 else R['uitext_calls']}||{R['path']}' + '\n').encode('utf-8'))
elif scan_option == '2':
    for R in roots:
        if R['uitext_calls'] > 0:
            open('libkeep.txt', 'ab').write(str(f'Native UI calls: {R['uitext_calls']}||{R['path']}' + '\n').encode('utf-8'))
elif scan_option == '3':
    for R in roots:
        if R['uitext_calls'] == 0:
            open('libkeep.txt', 'ab').write(str(f'Native UI calls: NO||{R['path']}' + '\n').encode('utf-8'))