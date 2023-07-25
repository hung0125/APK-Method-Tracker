from os import walk
import os.path

def get_smali_files(dir_path):
    smali_files = []
    for root, dirs, files in walk(dir_path):
        for file in files:
            if file.endswith(".smali"):
                smali_files.append(root[len(dir_path)+1:])
    return smali_files

base = input('input decompiled base path: ')
all_smali = get_smali_files(base)
roots = []

for F in all_smali:
    if not F in roots:
        roots.append(F)

if os.path.isfile('libkeep.txt'):
    os.remove('libkeep.txt')

open('libkeep.txt', 'ab').write('# Injector.py will only inject to the smali files that are contained in any of the following paths\n'.encode('utf-8'))

for R in roots:
    print(R)

    open('libkeep.txt', 'ab').write(str(R + '\n').encode('utf-8'))
    
