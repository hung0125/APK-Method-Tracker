#just the draft, algo is not optimized and I'm quite busy recently :(
import os
import glob
from os.path import basename

jadx = input("Jadx decompiled dir (full path): ")
trace = input("traceTmp folder (full path): ")

javaDoc = [os.path.join(dp, f) for dp, dn, filenames in os.walk(jadx) for f in filenames if os.path.splitext(f)[1] == '.java']

traceTmp = list(filter(os.path.isfile, glob.glob(trace + "/*")))
traceTmp.sort(key=lambda x: os.path.getmtime(x), reverse=True)


snippets = []

for T in traceTmp:
    found = False
    for J in javaDoc:
        if found:
            break
            
        cont = open(J, "rb").read().decode("utf-8").splitlines()
        for i in range(len(cont)):
            if basename(T[:-2]) in cont[i]:
                snipTmp = []
                for j in range(i-1, len(cont)):
                    if cont[j] == "}" or len(cont[j]) == 0:
                        break
                    snipTmp.append(cont[j])
                
                snippets.append(snipTmp)
                found = True
                break
            
for S in snippets:
    print("Method:")
    for _S in S:
        print(_S)
