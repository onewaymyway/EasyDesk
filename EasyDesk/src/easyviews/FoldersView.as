package easyviews {
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Label;
	import laya.utils.Handler;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import nodetools.devices.Paths;
	import nodetools.devices.PythonTools;
	import ui.easyviews.FoldersViewUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class FoldersView extends FoldersViewUI {
		public var FoldersFilePath:String;
		public var SaveFoldersFilePath:String;
		public function FoldersView() {
			folderTree.renderHandler = new Handler(this, resTreeRender);
			FoldersFilePath = FileTools.getPath(Paths.tempPath, "folders.json");
			SaveFoldersFilePath= FileTools.getPath(Paths.dataPath, "preFolders.json");
			folderTree.array = [];
			init();
		}
		
		private function init():void {
			freshBtn.on(Event.CLICK, this, onFreshBtn);
			closeSameBtn.on(Event.CLICK, this, onCloseSameBtn);
			closeAllBtn.on(Event.CLICK, this, onCloseAllBtn);
			
			saveBtn.on(Event.CLICK, this, saveFoleds);
			recoverBtn.on(Event.CLICK, this, recoverFolders);
			onFreshBtn();
		}
		
		private function saveFoleds():void
		{
			if (folderList)
			{
				FileManager.createJSONFile(SaveFoldersFilePath, folderList);
			}
		}
		
		private function recoverFolders():void
		{
			if (FileManager.exists(SaveFoldersFilePath))
			{
				var tList:Array;
				tList = FileManager.readJSONFile(SaveFoldersFilePath) as Array;
				if (tList)
				{
					var i:int, len:int;
					len = tList.length;
					for (i = 0; i < len; i++)
					{
						FileTools.openItem(tList[i]);
					}
				}
				Laya.timer.once(1000, this, onFreshBtn);
			}
		}
		private function resTreeRender(cell:Box, index:int):void {
			var item:Object = cell.dataSource;
			var label:Label;
			label = cell.getChildByName("label");
			var compStr:String;
			if (item) {
				label.text = item.path;
			}
		}
		
		private function onCloseAllBtn():void
		{
			trace("closeAll");
			PythonTools.callPython(PythonTools.CloseAll + " " + FoldersFilePath, new Handler(this, onFreshBtn));
		}
		
		
		private function onCloseSameBtn():void
		{
			trace("closeSame");
			PythonTools.callPython(PythonTools.CloseSame + " " + FoldersFilePath, new Handler(this, onCloseSameBack));
		}
		
		private function onCloseSameBack():void
		{
			onFreshBtn();
		}
		private function onFreshBtn():void {
			trace("onFreshBtn");
			PythonTools.callPython(PythonTools.GetFolders + " " + FoldersFilePath, new Handler(this, onFolderData));
		}
		
		private var folderList:Array;
		private function onFolderData():void {
			var dataO:Object;
			dataO = FileManager.readJSONFile(FoldersFilePath);
			folderList = dataO.list;
			folderList.sort();
			var i:int, len:int;
			
			len = folderList.length;
			trace(folderList);
			var treeList:Array;
			treeList = [];
			var tItem:Object;
			for (i = 0; i < len; i++)
			{
				tItem = { };
				tItem.path = FileManager.adptToCommonUrl(folderList[i]);
				treeList.push(tItem);
			}
			folderTree.array = treeList;
		}
	}

}