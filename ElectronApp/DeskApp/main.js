const electron = require('electron')
// Module to control application life.
const app = electron.app
// Module to create native browser window.
const BrowserWindow = electron.BrowserWindow

var mainWindow = null;

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  app.quit();
});
app.on('open-file', function(event,path) {
  console.log("openFile:",path);
});
function trace(msg)
{
     console.log(msg);
}
app.on('ready', function() {
  mainWindow = new BrowserWindow({
    width: 800,
    height: 400,
    "min-width":300,
		"min-height":200,
    'auto-hide-menu-bar': false,
    'use-content-size': true,
    'overlay-scrollbars': false,

    frame:true
  });
  var url="file://E:/wangwei/codes/layaair/trank/editor/layaaireditor/bin/h5/index.html";
  url="file://E:/wangwei/codes/layaair/trank/editor/layaaireditor/bin/h5/index.html";
  url='file://' + __dirname + '/h5/index.html';
  mainWindow.loadURL(url);

  mainWindow.focus();
 //mainWindow.openDevTools({detach:true});
  trace("hello electron")
  
  const {ipcMain} = require('electron')
  ipcMain.on('message', function(event, type,data) 
  {
  console.log(type,data);  // prints "ping"
  if(type=="cmd")
  {
  	dealCmd(data);
  }
   });
   
   function dealCmd(data)
   {
   	mainWindow[data.funName](data.param);
   }
 // readTest();
  //writeTest();
  //showOpen();
});

function readTest()
{
  var fs=require("fs");
  fs.readFile("package.json","utf8",function(err,data)
  {
    trace("read success");
    trace(err);
    trace(data);
  });
}
function writeTest()
{
  var fs=require("fs");
  fs.writeFile("orzooo.txt","hello");
}

function showOpen()
{
  var dialog=require("dialog");
  dialog.showOpenDialog();
}
function showSave()
{

}
