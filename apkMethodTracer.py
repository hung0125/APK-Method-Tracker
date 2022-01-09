from os.path import isfile, isdir
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
              "Lkotlinx/android/",
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
depth = int(input("Number of scans (Enter -1 = scan as much as possible, 0 = no scanning): "))

target = [allLibs.index(entry)]
scanCnt = 0
iscan = 0
newFind = True

while True:
    if depth == -1 and not newFind:
        break
    elif depth > -1 and scanCnt == depth:
        break
    
    scanCnt += 1
    findCnt = 0
    newFind = False
    tmp = len(target)
    for x in range(iscan, len(target)):
        cont = open(allFiles[target[x]], "rb").read().decode("utf-8")
        contC = "" #de-strings
        inStr = False
        for c in cont:
            if c == '"':
                inStr = True if not inStr else False
            elif not inStr:
                contC += c
        
        for i in range(len(allLibs)):
            if allLibs[i] in contC and not i in target:
                target.append(i)
                newFind = True
                findCnt += 1

    print(f'Scan {scanCnt} found {findCnt} smali')
    iscan = tmp
    
print(f'{len(target)} smali files need to be injected. Now begin...')

res = []
for T in target:
    res.append(allFiles[T])

chdir(prvWD)
inject(res, wkd)

print("Done. \nSee logs in /sdcard/traceTmp folder while running the app.\nThe backup is finished.")

