import os
import win32api
import time
import win32gui
import sys
import platform
import ctypes
import winproc
import json

myWorkDis={
    "notepad":"E:\\wangwei\\mydoc\\todos.txt",
    "E:\wangwei\mydoc":""
       }

exeDis={
    "D:\Program Files (x86)\Adobe\FlashBuilder4.6\Adobe Flash Builder 4.6\FlashBuilder.exe":"",
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe":" -disable-web-security",
    "C:\Program Files (x86)\Tencent\RTXC\RTX.exe":"",
    "D:\Program Files (x86)\FlashDevelop\FlashDevelop.exe":""
    }
oFolds=[]

openedExe={}
def readTxt(file):
    rst=[]
    f=open(file,"r")
    for line in f:
        line=line.strip()
        if len(line)>1:
            rst.append(line)
    f.close()
    return rst

def writeTxt(file,lines):
    f=open(file,"w")
    f.write("\n".join(lines))
    f.close()

def writeTxtFile(file,txt):
    f=open(file,"w",encoding='utf-8')
    f.write(txt)
    f.close()

    
def sOpen(exe,param):
    win32api.ShellExecute(0, 'open', exe,param,'',1)
    

def autoOpen():
    for param in myWorkDis:
        time.sleep(1)
        print("open:"+param)
        sOpen(param,myWorkDis[param])

def autoOpenExe():
    exeInfos()
    for exe in exeDis:
        sExe=exe.split("\\")
        sExe=sExe[len(sExe)-1]
        print(sExe)
        if isOpened(sExe):
            print("already open:"+exe)
        else:
            print("try open:"+exe)
            sOpen(exe,exeDis[exe])


def autoOpenFold():
    folds=readTxt("autoOpen/folds.txt")
    for fold in folds:
        sOpen(fold,"");
        time.sleep(1);
    

    
def getWindows():
    hld = win32gui.FindWindow(None,None)
    print(hld);

def getPros(hwnd,pname,data,param):
    print("p:",pname,data)
    if pname=="UxSubclassInfo":
        #print(win32gui.GetObject(289027344));
        pass;


def foChild(hwnd,cc):
    global oFolds;
    #print(hwnd," : "+win32gui.GetClassName(hwnd))
    cname=win32gui.GetClassName(hwnd)
    if cname=="ToolbarWindow32":
        tname=win32gui.GetWindowText(hwnd)
        
        #print("cname:"+tname)
        if tname.find("地址: ")>=0:
            addr=tname.replace("地址: ","")
            #print("addr:"+addr);
            oFolds.append(addr)
        #win32gui.EnumPropsEx(hwnd,getPros,None);

def findChild(hwnd,className):
    tchild=1;
    rst=hwnd;
    index=0;
    while tchild>0:
        tchild=win32gui.FindWindowEx(hwnd,index,None,None)
        index=tchild;
        if tchild>0:
            print("child:"+win32gui.GetClassName(tchild))
        

def foo(hwnd,mouse):
  #去掉下面这句就所有都输出了，但是我不需要那么多
    clz=win32gui.GetClassName(hwnd)
    #print(win32gui.GetWindowText(hwnd))
    #print(clz)
    if not clz=="CabinetWClass":
        return;
    #print(hwnd," : ")
    if 1==1:
        #print(win32gui.GetWindowText(hwnd))
        win32gui.EnumChildWindows(hwnd,foChild ,None)
        
        #rebar=win32gui.FindWindowEx(hwnd,0,"WorkerW",None)
        #rebar=win32gui.FindWindowEx(rebar,0,"ReBarWindow32",None)
        #findChild(rebar,"ReBarWindow32");
        #print("rebar:",rebar)

def getOpenFolds():
    win32gui.EnumWindows(foo, 0)

def saveInfos(filePath):
    getOpenFolds()
    sData={}
    sData["list"]=oFolds
    print('\n'.join(oFolds))
    saveStr=json.dumps(sData,ensure_ascii=False)
    print(saveStr)
    writeTxtFile(filePath,saveStr)

def exeInfos():
    procList = winproc.getProcList()
    pList={}
    for pp in procList:
        tExe=pp.szExeFile.decode('gbk')
        pList[tExe]=True
        #print("exe:"+tExe)
    global openedExe
    openedExe=pList

def isOpened(exe):
    global openedExe
    if exe in openedExe:
        return True
    return False;
        



#autoOpen();
#getWindows();
#getWindows();
#print('ok')
if __name__ == "__main__":
    print("args:",sys.argv)
    args=sys.argv
    if len(args)==2:
        #print("arg2")
        #autoOpenFold();
        #autoOpen();
        #autoOpenExe();

        saveInfos(args[1]);
    else:
        print("argU");
        saveInfos();
        #exeInfos();
        #autoOpenExe()
       
