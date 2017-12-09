import os
import shutil
import sys
import win32api

def copyFiles(sourceDir,  targetDir): 
    if sourceDir.find(".svn") > 0: 
        return 
    for file in os.listdir(sourceDir): 
        sourceFile = os.path.join(sourceDir,  file) 
        targetFile = os.path.join(targetDir,  file) 
        if os.path.isfile(sourceFile): 
            if not os.path.exists(targetDir):  
                os.makedirs(targetDir)  
            if not os.path.exists(targetFile) or(os.path.exists(targetFile) and (os.path.getsize(targetFile) != os.path.getsize(sourceFile))):  
                    open(targetFile, "wb").write(open(sourceFile, "rb").read()) 
        if os.path.isdir(sourceFile): 
            First_Directory = False 
            copyFiles(sourceFile, targetFile)
            
def copyFileToTar(srcFile,tarFile):
    print("copyFileToTar",srcFile,tarFile);
    if os.path.exists(srcFile):
        pass;
    else:
        print("!exitst:",srcFile)
        return;

    if os.path.isdir(srcFile):
        copyFiles(srcFile,tarFile);
    else:
        shutil.copyfile(srcFile,tarFile);

def sOpen(exe,param):
    win32api.ShellExecute(0, 'open', exe,param,'',1)

compileExe="E:/wangwei/codes/laya/laya.js.exe"
compileParam="E:/wangwei/codes/LayaAir/trank/Editor/LayaAirEditor/LayaAirEditor.as3proj"+";iflash=false;chromerun=false;outlaya=true";
#sOpen(compileExe,compileParam);
os.system(compileExe+" "+compileParam)
print("compile complete");
IDEPath="D:\ideweek/"
exePath=IDEPath+"LayaAir.exe";
tarDir=IDEPath+"resources/app/out/vs/layaEditor/h5/layabuilder.max.js"
srcDir="E:/wangwei/codes/LayaAir/trank/Editor/LayaAirEditor/bin/h5/layaaireditor.max.js"

#shutil.copyfile(srcDir,tarDir)

libFile="E:/wangwei/codes/LayaAir/trank/Editor/LayaAirEditor/bin/h5/laya.js"
ideFile="E:/wangwei/codes/LayaAir/trank/Editor/LayaAirEditor/bin/h5/layaaireditor.max.js"

tarLibFile=IDEPath+"resources/app/out/vs/layaEditor/h5/laya.js"
tarIDEFile=IDEPath+"resources/app/out/vs/layaEditor/h5/layabuilder.max.js"

shutil.copyfile(libFile,tarLibFile)
shutil.copyfile(ideFile,tarIDEFile)
print("copy complete")
sOpen(exePath,"");
print("workDone");
