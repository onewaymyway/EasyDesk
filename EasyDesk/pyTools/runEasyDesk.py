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

scriptPath=os.getcwd()
#print(scriptPath)
tR=os.path.abspath("../../")
#print(tR)
myRoot=tR.replace("\\","/")+"/"
compileExe="laya.js.exe"
compileParam=myRoot+"/EasyDesk/EasyDesk.as3proj"+";iflash=false;chromerun=false;outlaya=false";
#sOpen(compileExe,compileParam);
os.system(compileExe+" "+compileParam)
print("compile complete");

exePath=myRoot+"Electron/EasyDesk.exe";
tarDir=myRoot+"ElectronApp/DeskApp/h5/EasyDesk.max.js"
srcDir=myRoot+"EasyDesk/bin/h5/EasyDesk.max.js"
appDir=myRoot+"ElectronApp/DeskApp"

shutil.copyfile(srcDir,tarDir)
print("copy complete")
sOpen(exePath,appDir);
print("workDone");
