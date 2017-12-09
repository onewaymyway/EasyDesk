import os
import shutil
import sys

toCopyDirs=[
    "codeTemplate",
    "libs",
    "renders",
    "laya",
    "h5/renders",
    "h5/comp.json",
    "h5/comp.png",
    "h5/components.json",
    "h5/components.png",
    "h5/cursor.json",
    "h5/cursor.png",
    "h5/news.json",
    "h5/news.png",
    "h5/play.json",
    "h5/play.png",
    "h5/view.json",
    "h5/view.png",
    "h5/index.html",
    "h5/layaaireditor.max.html",
    "h5/layaaireditor.max.js"
    
];
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



def publishFile(srcFolder,tarFolder):
    print("publicFile:",srcFolder,tarFolder)

    for tPath in toCopyDirs:
        copyFileToTar(srcFolder+"\\"+tPath,tarFolder+"\\"+tPath)

    print("work done")

scriptPath=os.getcwd()
parentPath=os.path.dirname(scriptPath);
print(scriptPath,parentPath);

srcPath=parentPath+"/bin";
#srcPath="E:/wangwei/codes/LayaAir/trank/Editor/LayaAirEditor/bin";
tarPath="E:/wangwei/codes/LayaAir/trank/Editor/LayaAirEditor/bin1";




if  __name__ =="__main__":
    if len(sys.argv)==2:
        tarPath=sys.argv[1]
    if len(sys.argv)==3:
        srcPath=sys.argv[1]
        srcPath=sys.argv[2]
    publishFile(srcPath,tarPath)
