from os.path import isfile, isdir, basename
from time import time
from injector import inject
from platform import platform
from os import chdir, getcwd
from shutil import rmtree
import subprocess
import sys

#Feel free to config the list below. Tips: add API libraries, they're usually useless for analysis.
ignoreLibs = ["Landroid/",
              "Landroidx/",
              "Lcom/google/",
              "Lorg/apache/",
              "Lkotlin/",
              "Lkotlinx/",
              "Lokhttp3/",
              "Lcom/facebook/",
              "Lio/reactivex/",
              "Ljavax/inject/",
              "Lokio/",
              "Lbumptech/glide/",
              "Lcom/fasterxml/"]

print("Feel free to config the script.\nDelete 'libs.txt' & 'paths.txt' in the decompiled folder to rescan.\nBetter work with Jadx-gui.\n")

def outFile(pathLs):
    resOut = ""
    resPout = ""
    
    for i in range(len(pathLs)):
        if (i+1) % 500 == 0 or (i+1) == len(pathLs):
            print(f'Scanned {i+1}/{len(pathLs)}')
        	
        head = open(pathLs[i],  "r").read().splitlines()[0]
        out = head.split()[-1]
        pout = pathLs[i]
        
        for L in ignoreLibs:
            if out.startswith(L):
                out = ""
                
        if len(out) > 0 and not 'interface abstract' in head:
            if i < len(pathLs) - 1:
                out, pout = out + "\n", pout + "\n"
 
            resOut, resPout = resOut + out, resPout + pout
            
    open("libs.txt", "w").write(resOut)
    open("paths.txt", "w").write(resPout)

rmtree("__pycache__")
prvWD = getcwd()
wkd = input("Full path of the decompiled root dir: ")
chdir(wkd)

#find paths
if isdir("smali"):
    if not isfile("libs.txt") or not isfile("paths.txt"):
        print("Making path database for first start...")
        if platform().startswith("Windows"):
            tmp = subprocess.run(f'where /R "{getcwd()}" *.smali', stdout=subprocess.PIPE).stdout.decode('utf-8').splitlines()
            if len(tmp[-1]) == 0: 
                tmp.pop(-1)
            outFile(tmp)
            
        elif platform().startswith("Linux"):
            tmp = subprocess.run(["find", f"{getcwd()}", "-name", "*.smali"], stdout=subprocess.PIPE).stdout.decode('utf-8').splitlines()
            if len(tmp[-1]) == 0: 
                tmp.pop(-1)
            outFile(tmp)

        else:
            sys.exit('Your system does not support the script.')

else:
    sys.exit("Invalid folder. Please check manually")

go = True if input("Next step is modification. Continue? (yes/press enter to exit): ") == "yes" else False

if not go:
    sys.exit("Ended.")

#Lcom/crocusgames/whereisxur/mainscreens/WishListResultsActivity;
entry = input("Entry (Lxxx/xxx/xxx;): ").replace(" ", "")

allLibs = open('libs.txt', 'rb').read().decode('utf-8').splitlines()
allFiles = open('paths.txt', 'rb').read().decode('utf-8').splitlines()

#search lib
filters = input("*Define targets to catch (no input = all)*\noptions: (b)yte, (c)har, (d)ouble, (f)loat, (i)nt, (s)hort, s(t)ring (v)oid, (j)long, (z)boolean\nE.g., 'itv' targets only int, String, void methods\n=>")
filLs = []
checkF = "bcdfistvjz"
for i in range(len(filters)):
    if not filters[i] in checkF:
        sys.exit("Wrong filter")
    elif filters[i] == "t":
        filLs.append("Ljava/lang/String;")
    else:
        filLs.append(filters[i].upper())

print("Please wait...\n")
target = [[allLibs.index(entry)]] #[[],[],[]] = scan 1, 2, 3
methCnt = []
while True:
    newTar = []
    methSubCnt = 0
    for x in range(len(target[-1])):
        cont = open(allFiles[target[-1][x]], "rb").read().decode("utf-8").splitlines()
        contC = "" #de-strings

        for C in cont:
            if C.startswith('.method ') and not ' constructor ' in C and not ' abstract ' in C:
                methSubCnt += 1
            inStr = False
            for S in C:
                if S == '"':
                    inStr = True if not inStr else False
                elif not inStr:
                    contC += S

        for i in range(len(allLibs)):
            if allLibs[i] in contC:
                val = True
                for T in target:
                    if i in T or i in newTar:
                        val = False
                        break
                if val:
                    newTar.append(i)

    if len(newTar) > 0:
        target.append(newTar)
        methCnt.append(methSubCnt)
    else:
        lastMethSubCnt = 0
        for y in range(len(target[-1])):
            cont = open(allFiles[target[-1][y]], "rb").read().decode("utf-8").splitlines()
            for C in cont:
                if C.startswith('.method ') and not ' constructor ' in C and not ' abstract ' in C:
                    lastMethSubCnt += 1
        methCnt.append(lastMethSubCnt)
        break

    
print("Preview of the first max 10 scans is as follows: ")
print(f"Initial class: {basename(allFiles[target[0][0]])} || Method count: {methCnt[0]}")
if len(target) == 1:
    print("No new targets found")
else:
    prevAccuTar = 1
    prevMethCnt = methCnt[0]
    for i in range(len(target)):
        if i > 0:
            accuTar = prevAccuTar + len(target[i])
            prevAccuTar = accuTar

            accuMethCnt = prevMethCnt + methCnt[i]
            prevMethCnt = accuMethCnt
            print(f"Scan {i}: {len(target[i])} required class(es), accumulation = {accuTar} || method count = {methCnt[i]}, accumulation = {accuMethCnt}")

depth = int(input("\nDefine number of injections (1 inject = 1 scan) actually needed\nEnter -1 = inject EVERYTHING, 0 = only inject the INITIAL CLASS\n: ")) + 1
if depth == 0:
    depth = len(target)

res = []
for i in range(min(depth, len(target))):
    for T in target[i]:
        res.append(allFiles[T])

chdir(prvWD)
inject(res, wkd, filLs)

print("Done. \nSee logs in /sdcard/traceTmp folder while running the app.\nThe backup is finished.")

