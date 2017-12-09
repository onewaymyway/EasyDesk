#-*- coding: utf-8 -*-  ##设置编码方式
import os
import win32api
import time
import win32con
import win32gui
import sys
import platform
import ctypes
import winproc

def getPros(hwnd,pname,data,param):
    print("p:",pname,data,param)
    #cc=win32gui.GetObject(pname)
    #print(cc)
    if pname=="UxSubclassInfo":
        #print(win32gui.GetObject(289027344));
        pass;
    
def foChild(hwnd,cc):
    #print(hwnd," : "+win32gui.GetClassName(hwnd))
    cname=win32gui.GetClassName(hwnd)

    tname=win32gui.GetWindowText(hwnd)

    if cname=="SysTreeView32":
        print(tname)
       
        pass
    
    if tname=="撤单":
        print("name:"+tname,"clz:",cname,hwnd)
        print(win)
        #win32gui.EnumPropsEx(hwnd,getPros,None);
        #win32gui.PostMessage(hwnd, win32con.WM_LBUTTONDOWN, win32con.MK_LBUTTON, 0)

        #win32gui.PostMessage(hwnd, win32con.WM_LBUTTONUP, win32con.MK_LBUTTON, 0)
        #win32gui.PostMessage(hwnd, win32con.BM_CLICK, win32con.MK_LBUTTON, 0)
        win32gui.SendMessage(hwnd,win32con.BM_CLICK,None,None)
        #win32gui.SendMessage(hwnd,win32con.WM_LBUTTONUP,None,None)
        #win32gui.SendMessage(hwnd,win32con.WM_LBUTTONDOWN,None,None)
        
        #win32gui.GetDlgItem

        #b=win32gui.GetDlgItem(win,hwnd)
        #b.postMessage(win32con.BM_CLICK)
        #win32gui.PostMessage(hwnd, win32con.WM_LBUTTONDOWN, win32con.MK_LBUTTON, 0)

def foo(hwnd):
  #去掉下面这句就所有都输出了，但是我不需要那么多
    clz=win32gui.GetClassName(hwnd)
    #print(win32gui.GetWindowText(hwnd))
    print(clz)

    #print(hwnd," : ")
    if 1==1:
        #print(win32gui.GetWindowText(hwnd))
        win32gui.EnumChildWindows(hwnd,foChild ,None)
        
        #rebar=win32gui.FindWindowEx(hwnd,0,"WorkerW",None)
        #rebar=win32gui.FindWindowEx(rebar,0,"ReBarWindow32",None)
        #findChild(rebar,"ReBarWindow32");
        #print("rebar:",rebar)

    
win = win32gui.FindWindow("TdxW_MainFrame_Class", None)
print(win)
hwnd = win32gui.FindWindowEx(win, 0, None, "市价卖出")

print(hwnd)
#foo(win)
