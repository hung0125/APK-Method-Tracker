#just the draft, algo is not optimized and I'm quite busy recently :(
import os
import glob
from os.path import basename

jadx = input("Jadx decompiled dir (full path): ")
trace = input("traceTmp folder (full path): ")

javaDoc = [os.path.join(dp, f) for dp, dn, filenames in os.walk(jadx) for f in filenames if os.path.splitext(f)[1] == '.java']

traceTmp = list(filter(os.path.isfile, glob.glob(trace + "/*")))
traceTmp.sort(key=lambda x: os.path.getmtime(x))

#sum of java files
javaCont = []

for J in javaDoc:
    javaCont.extend(open(J, "rb").read().decode("utf-8").splitlines())
    

snippets = []

for T in traceTmp:
    for i in range(len(javaCont)):
        if basename(T[:-2]) in javaCont[i]:
            snipTmp = []
            for j in range(i-1, len(javaCont)):
                if javaCont[j] == "}" or len(javaCont[j]) == 0:
                    break
                snipTmp.append(javaCont[j])
            
            snippets.append(snipTmp)
            break
            
for S in snippets:
    print("Method:")
    for _S in S:
        print(_S)
