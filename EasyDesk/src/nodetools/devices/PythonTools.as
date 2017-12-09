package nodetools.devices {
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author ww
	 */
	public class PythonTools {
		public static const PythonExePath:String="C:/Python34/python.exe";
		public static const PythonFolder:String;
		public static const GetFolders:String = "autoPy.py";
		public static const CloseSame:String = "autoCloseSame.py";
		public static const CloseAll:String = "autoClose.py";
		public function PythonTools() {
		
		}
		public static function callPython(cmdStr:String, complete:Handler):void {
			cmdStr = PythonExePath + " " +PythonFolder+ cmdStr;
			CMDShell.execute(cmdStr, function callBackTmp(err:String, stdOut:*, stdErr:String):void {
					trace("err:", err);
					//trace("stdOut:",stdOut);
					trace("stdErr:", stdErr);
					
					trace("stdOut:", CMDShell.decode(stdOut, "gbk"));
					if (complete)
					{
						complete.run();
					}
				})
		}
	}

}