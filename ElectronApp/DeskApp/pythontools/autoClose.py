import os
import win32api
import time
import win32gui
import sys
import platform
import ctypes
import winproc
from win32.lib import win32con

oFolds=[]

openedExe={}

isFolder=False;


def foChild(hwnd,cc):
    global oFolds;
    global isFolder
    #print(hwnd," : "+win32gui.GetClassName(hwnd))
    cname=win32gui.GetClassName(hwnd)
    if cname=="ToolbarWindow32":
        tname=win32gui.GetWindowText(hwnd)
        
        #print("cname:"+tname)
        if tname.find("地址: ")>=0:
            addr=tname.replace("地址: ","")
            isFolder=True
            #print("addr:"+addr);
            oFolds.append(addr)

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
    global isFolder
    isFolder=False
    clz=win32gui.GetClassName(hwnd)
    if not clz=="CabinetWClass":
        return;
    #print(hwnd," : ")
    if 1==1:
        #print(win32gui.GetWindowText(hwnd))
        win32gui.EnumChildWindows(hwnd,foChild ,None)
        if isFolder:
            print(win32gui.GetWindowText(hwnd))
            win32gui.PostMessage(hwnd, win32con.WM_CLOSE, 0, 0)


def getOpenFolds():
    win32gui.EnumWindows(foo, 0)


        
if __name__ == "__main__":
    print("args:",sys.argv)
    args=sys.argv
    getOpenFolds()
       
