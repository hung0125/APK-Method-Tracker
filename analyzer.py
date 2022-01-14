import os
import glob
import sys
from time import time
from os.path import basename
from pathlib import Path

jadx = input("Jadx decompiled dir, the INJECTED version (full path): ").replace("\\", "/")
trace = input("traceTmp folder (full path): ").replace("\\", "/")

if not jadx.endswith("/"):
    jadx += "/"

while jadx.endswith("//"):
    jadx = jadx[:-1]

javaDoc = [os.path.join(dp, f) for dp, dn, filenames in os.walk(jadx) for f in filenames if os.path.splitext(f)[1] == '.java']

traceTmp = list(filter(os.path.isfile, glob.glob(trace + "/*")))
traceTmp.sort(key=lambda x: int(open(x, "r").read()))

snippets = []

for T in traceTmp:
    found = False
    for J in javaDoc:
        J = J.replace("\\", "/")
        if found:
            break
       
        pCheck = "/".join(J[len(jadx):].split("/")[:-1])
        classPth = "/".join(basename(T).split("]")[0][2:].split(".")[:-1])

        if pCheck == "defpackage":
            pCheck = ""
            
        if pCheck != classPth:
            continue
        
        cont = open(J, "rb").read().decode("utf-8").splitlines()
            
        for i in range(len(cont)):
            if basename(T[:-2]) in cont[i]:
                snipTmp = []
                for j in range(i-1, len(cont)):
                    if cont[j] == "}" or (len(cont[j]) == 0 and cont[j-1].endswith("}")):
                        break
                    
                    snipTmp.append(cont[j])
                
                snippets.append(snipTmp)
                found = True
                print(f"Found: {basename(T[:-2])}")
                break
    if not found:
        print(f"Not found: {basename(T[:-2])}")
        snippets.append(["Jadx's error, the method could not be decompiled."])

ts = int(time())
os.mkdir(f"TraceDetail_{ts}")
os.mkdir(f"TraceDetail_{ts}/trace")

html = "<html><body><h1>Analyzer.py for apkMethodTracker</h1><h3>Note: Sorted by file modification time (from oldest to newest). The order can be affected by some factors like threading.</h3><button id = 'tops' onclick='topSwitch()' style='background: cyan;'>Show all</button><br><br>"
for i in range(len(snippets)):
    snipCont = "\n".join(snippets[i])
    open(f"TraceDetail_{ts}/trace/{basename(traceTmp[i])}", "wb").write(snipCont.encode("utf-8"))

    curMethCmpnts = basename(traceTmp[i][:-2]).split("--")
    curClassName = curMethCmpnts[0]
    curMethName = f"<a style = 'color:blue'>{curMethCmpnts[1].split('(')[0]}</a>"
    curMethTail = curMethCmpnts[1].split("(")[1]
    butName = f'{curClassName}--{curMethName}({curMethTail}'
    
    htCode = snipCont.replace('\n', '<br>').replace(' ', '&nbsp;')
    for T in traceTmp:
        methNames = ["." + basename(T).split("--")[1].split("(")[0] + "(",
                     " " + basename(T).split("--")[1].split("(")[0] + "(",
                     "(" + basename(T).split("--")[1].split("(")[0] + "("]
        for M in methNames:
            htCode = htCode.replace(M, f"<a style = 'color:lightseagreen'>{M}</a>")
        
    para = f'"c{i}"'
    html += f"<button onclick='showSwitch({para})'>{i+1} | {butName}</button><div id = {para} style = 'display: none;'>{htCode}</div><br>"

func1 = "function showSwitch(y) {var x = document.getElementById(y);x.style.display = x.style.display === 'none'?'block':'none';}"
func2 = "function topSwitch() {var b = document.getElementById('tops'); var x = document.getElementsByTagName('div');    if(b.innerText == 'Show all') { for (let i = 0; i < x.length; i++)  {  x[i].style.display = 'block';  } b.innerText = 'Hide all'; }else { for (let i = 0; i < x.length; i++)  {  x[i].style.display = 'none';  } b.innerText = 'Show all'; }}"
html += f"<script>{func1}\n{func2}</script></body></html>"
open(f"TraceDetail_{ts}/results.html", "w").write(html)

print(f"\nOK. Head to the folder 'TraceDetail_{ts}' for more info.")
