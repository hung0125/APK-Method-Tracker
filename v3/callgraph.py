from os import walk, path
from tqdm import tqdm
import re


class_pattern = r"L[^;]+;"
addition_prefix = "(); "
def get_relations(smali_path:str = None, content_lines:list[str] = None)->set:
    cont = content_lines if content_lines else open(smali_path, 'rb').read().decode('utf-8').splitlines()
    rel = set()

    for L in cont:
        begin_field = L.startswith('.field')
        begin_string = L.strip().startswith('const-string')

        if not begin_string and not begin_field: 
            for P in addition_prefix:
                classes = re.findall('\\' + P + class_pattern, L)
                for C in classes:
                    rel.add(C[1:])

        elif begin_field:
            test = L.split(':')[1].split(' ')[0]
            res = re.findall(class_pattern, test)
            if len(res) > 0:
                rel.add(res[0])
    return rel

def get_smali_files(dir_path, root_class):
    fpaths = []
    bpaths = []
    bpaths_map = {}
    classname_map = {} # Lclass name -> file path
    root_path = ''
    root_discovery = None
    
    for root, dirs, files in walk(dir_path):
        base_path = root[len(dir_path)+1:]
        for file in tqdm(files):
            if file.endswith(".smali"):
                smali_path = path.join(root, file)
                fpaths.append(smali_path)
                if not base_path in bpaths_map:
                    bpaths_map[base_path] = True
                    bpaths.append(base_path)
                
                cont = open(smali_path, 'rb').read().decode('utf-8').splitlines()
                cname = cont[0].split(' ')[-1]
                classname_map[cname] = smali_path

                if cname == root_class:
                    root_path = smali_path
                    root_discovery = get_relations(content_lines=cont)

    root_discovery = root_discovery.intersection(classname_map.keys())
    return {'fpaths': fpaths, 'bpaths': bpaths, 'pathdict': classname_map, 'root': root_path, 'discovery': root_discovery}

pth = input('Input decomplied base directory: ')
inp = input('Input launcher activity: xxx.yyy.zzz: ')
root_class = f'L{inp.replace(".", "/")};'
init_results = get_smali_files(pth, root_class)

if not init_results['root']:
    print('Specified root class not found.')
    exit(1)


# do the algo (https://wiki.python.org/moin/TimeComplexity)
class_map = init_results['pathdict']
set_list = [init_results['discovery']] # set
visited = set()
visited.add(root_class)
discovery = set_list[0] # set
level = 0

while len(discovery) > 0:
    print(f'Extracting at level {level}...')
    cur_discovery = set()
    for CLASS in discovery:
        if CLASS in class_map and not CLASS in visited: # class can open && not visited
            visited.add(CLASS)
            new_classes = get_relations(smali_path=class_map[CLASS])
            for CANDIDATE in new_classes:
                if CANDIDATE in class_map and not CANDIDATE in visited:
                    cur_discovery.add(CANDIDATE)
    
    if len(cur_discovery) > 0:
        set_list.append(cur_discovery)
    discovery = cur_discovery
    level += 1

for LS in set_list:
    open('callgraph.txt', 'ab').write(str(','.join(LS) + '\n').encode('utf-8'))
    # print(LS)
    
for L in class_map:
    if L.startswith('Ljava'):
        print(L)