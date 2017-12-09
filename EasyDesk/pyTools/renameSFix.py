import os
import shutil


def renameDirFiles(dirPath,outDir):
   # files=os.listdir(dirPath);
    print("renameDirFiles")
    for rt,dirs,files in os.walk(dirPath):
            for filename in files:
                arr=os.path.splitext(filename)
                tFile=rt+"\\"+filename
                renameFile(tFile,dirPath,outDir)
                
                
        
def renameFile(filename,oPath,nPath):
    arr=os.path.splitext(filename)
    typeName=arr[len(arr)-1];
    fileSName=arr[0];
    if typeName in renameDic:
        tFile=fileSName+renameDic[typeName]
        outFilePath=tFile.replace(oPath,nPath)
        ensureDir(outFilePath);
        shutil.copyfile(filename,outFilePath)
    else:
        tFile=filename
        outFilePath=tFile.replace(oPath,nPath)
        ensureDir(outFilePath);
        shutil.copyfile(filename,outFilePath)

def ensureDir(file):
    arr=os.path.split(file)
    if os.path.exists(arr[0]):
        pass;
    else:
        os.makedirs(arr[0])
        
renameDic={
    ".xml":".ui"
};    

dPath="E:\\wangwei\\codes\\LayaAir\\trank\\Editor\\LayaAirEditor\\pyTools\\laya"
outPath="E:\\wangwei\\codes\\LayaAir\\trank\\Editor\\LayaAirEditor\\pyTools\\layaOut"
outPath=dPath+"Out"

renameDirFiles(dPath,outPath);
print("workEnd")
