package  
{
	import easyviews.EasyMain;
	import electrontools.drags.SystemDragOverManager;
	import electrontools.menus.ContextMenu;
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.net.Loader;
	import laya.renders.paths;
	import laya.ui.Styles;
	import laya.utils.Handler;
	import nodetools.devices.CMDShell;
	import nodetools.devices.Device;
	import nodetools.devices.FileTools;
	import nodetools.devices.OSInfo;
	import nodetools.devices.Paths;
	import nodetools.devices.PythonTools;
	import nodetools.devices.SystemSetting;
	/**
	 * ...
	 * @author ww
	 */
	public class EasyDesk 
	{
		
		public function EasyDesk() 
		{
			Laya.init(800, 600);
			Laya.stage.scaleMode = Stage.SCALE_FULL;
			UIConfig.touchScrollEnable = false;
			Styles.buttonLabelColors = ["#ffffff", "#32cc6b", "#ff0000", "#C0C0C0"];
			init();
			var resList:Array;
			resList = [{"url":"res/atlas/comp.json","type":Loader.ATLAS}];
			Laya.loader.load(resList, new Handler(this, test));
		}
		
		private function init():void {
			Device.Buffer = __JS__("Buffer");
			Device.init();
			SystemSetting.isCMDVer = true;
			OSInfo.init();
			//Browser.userAgent = OSInfo.type;
			//Browser.userAgent = OSInfo.type;
			//Browser.userAgent = OSInfo.type;
			//trace(Browser.userAgent);
			//CMDShell.init();
			//Device.init();
			//初始化文件系统
			FileTools.init2();
			CMDShell.init();
			//CMDShell.childProcess = Device.requireRemote("child_process");
			PythonTools.PythonFolder = FileTools.getAppPath("pythontools") + "/";
			Paths.tempPath = FileTools.getAppPath("tempdata") + "/";
			Paths.dataPath = FileTools.getAppPath("data") + "/";
			SystemDragOverManager.init();
			ContextMenu.init();
		
		}
		private function test():void
		{
			trace("AppPath:",FileTools.appPath);
			var mainView:EasyMain;
			mainView = new EasyMain();
			mainView.left = mainView.top = mainView.right = mainView.bottom = 10;
			Laya.stage.addChild(mainView);
		}
		
	}

}