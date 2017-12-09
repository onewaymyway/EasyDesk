package easyviews {
	import easyviews.managers.FolderManager;
	import electrontools.drags.SystemDragOverManager;
	import electrontools.menus.ContextMenu;
	import electrontools.menus.MenuManager;
	import laya.debug.tools.ObjectTools;
	import laya.events.Event;
	import laya.utils.Handler;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;
	import ui.easyviews.ManagerViewUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class ManagerView extends ManagerViewUI {
		
		private var folderMenu:ContextMenu;
		private var typeMenu:ContextMenu;
		public function ManagerView() {
			typeList.array = [];
			folderList.array = [];
			FolderManager.loadFolderFile();
			
			addBtn.on(Event.CLICK, this, onAddBtn);
			freshBtn.on(Event.CLICK, this, onFreshBtn);
			saveBtn.on(Event.CLICK, this, onSaveBtn);
			
			typeList.renderHandler = new Handler(this, typeListRender);
			typeList.mouseHandler = new Handler(this, onTypeListMouse);
			
			folderList.renderHandler = new Handler(this, folderListRender);
			folderList.mouseHandler = new Handler(this, onFolderListMouse);
			
			folderList.on(Event.RIGHT_MOUSE_UP, this, onFolderListRightUp);
			typeList.on(Event.RIGHT_MOUSE_UP, this, onTypeListRightUp);
			freshTypeList();
			
			typeList.scrollBar.autoHide = true;
			folderList.scrollBar.autoHide = true;
			//typeList.scrollBar.dr
			
			folderList.on(Event.DOUBLE_CLICK, this, onFileDoubleClick);
			folderList.on(SystemDragOverManager.SystemDrag, this, onDragFile);
			
			folderMenu = ContextMenu.createMenuByArray(["删除"]);
			folderMenu.on(Event.SELECT, this, onFolderMenuSelect);
			
			typeMenu = ContextMenu.createMenuByArray(["删除"]);
			typeMenu.on(Event.SELECT, this, onTypeMenuSelect);
		}
		private function onTypeMenuSelect(name:String):void {
			trace("menu:",name);
			switch (name) {
				case "删除":
					if (typeList.selectedItem)
					{
						if (FolderManager.getTypes())
						{
							ObjectTools.removeFromArr(FolderManager.getTypes(), typeList.selectedItem);
							freshTypeList();
						}
					}
					break;
			}
		}
		private function onFolderMenuSelect(name:String):void {
			trace("menu:",name);
			switch (name) {
				case "删除":
					if (folderList.selectedItem)
					{
						if (tTypeO.files)
						{
							ObjectTools.removeFromArr(tTypeO.files, folderList.selectedItem);
							freshFolderList();
						}
					}
					break;
			}
		}
		
		private function onFileDoubleClick():void {
			
			if (folderList.selectedItem) {
				
				trace("doubleClick:", folderList.selectedItem);
				FileTools.openItem(folderList.selectedItem);
			}
		}
		private var tTypeO:Object;
		
		private function onDragFile(data:Object):void {
			trace("dragData:", data);
			if (data && data.data) {
				data = data.data;
				if (data.files && data.files[0]) {
					var tFile:Object;
					tFile = data.files[0];
					var tFilePath:String;
					tFilePath = tFile.path;
					if (FileTools.isDirectory(tFilePath)) {
						
					}
					else {
						tFilePath = FileTools.getFolder(tFilePath);
					}
					tFilePath = FileManager.adptToCommonUrl(tFilePath);
					if (tTypeO) {
						FolderManager.addFolderToType(tTypeO.type, tFilePath);
						freshFolderList();
					}
				}
			}
		}
		
		
		private function onTypeListRightUp(e:Event):void
		{

				if (typeList.selectedItem) {
					typeMenu.show();
				}
			
		}
		
		private function onFolderListRightUp(e:Event):void
		{

				if (folderList.selectedItem) {
					folderMenu.show();
				}
			
		}
		
		private function onFolderListMouse(e:Event, index:int):void {
			var cell:Box = folderList.getCell(index);
			var item:Object = cell.dataSource;
			if (!item) {
				folderList.selectedIndex = -1;
				return;
			}
			
			if (e.type == Event.MOUSE_DOWN) {
				folderList.selectedIndex = index;
				if (typeList.selectedItem) {
					
				}
			}
			
		}
		
		private function onTypeListMouse(e:Event, index:int):void {
			var cell:Box = typeList.getCell(index);
			var item:Object = cell.dataSource;
			if (!item) {
				typeList.selectedIndex = -1;
				return;
			}
			
			if (e.type == Event.MOUSE_DOWN) {
				typeList.selectedIndex = index;
				if (typeList.selectedItem) {
					trace(typeList.selectedItem);
					tTypeO = typeList.selectedItem;
					freshFolderList();
				}
			}
		}
		
		private function folderListRender(cell:Box, index:int):void {
			var item:Object = cell.dataSource;
			var label:Label;
			label = cell.getChildByName("label");
			var compStr:String;
			if (item) {
				label.text = item;
			}
		}
		
		private function typeListRender(cell:Box, index:int):void {
			var item:Object = cell.dataSource;
			var label:Label;
			label = cell.getChildByName("label");
			var compStr:String;
			if (item) {
				label.text = item.type;
			}
		}
		
		private function onSaveBtn():void {
			FolderManager.saveFolderFile();
		}
		
		private function onFreshBtn():void {
		
		}
		
		private function onAddBtn():void {
			if (typeInput.text != "") {
				FolderManager.addType(typeInput.text);
				freshTypeList();
			}
		}
		
		public function freshTypeList():void {
			typeList.array = FolderManager.getTypes();
		}
		
		public function freshFolderList():void {
			if (tTypeO) {
				tTypeO.files.sort();
				folderList.array = tTypeO.files;
				foldersTitle.text = tTypeO.type;
			}
		
		}
	}

}