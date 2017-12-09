///////////////////////////////////////////////////////////
//  ContextMenu.as
//  Macromedia ActionScript Implementation of the Class ContextMenu
//  Created on:      2015-10-24 下午2:58:37
//  Original author: ww
///////////////////////////////////////////////////////////

package electrontools.menus {
	import electrontools.DisTools;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.utils.Browser;
	
	/**
	 *
	 * @author ww
	 * @version 1.0
	 *
	 * @created  2015-10-24 下午2:58:37
	 */
	public class ContextMenu extends Box {
		public function ContextMenu() {
			super();
		}
		
		public static function init():void {
			Laya.stage.on(Event.CLICK, null, cleanMenu);
		}
		private static var _menuList:Array = [];
		
		public static function cleanMenu(e:Event = null):void {
			var i:int;
			var len:int;
			len = _menuList.length;
			for (i = 0; i < len; i++) {
				if (_menuList[i]) {
					_menuList[i].removeSelf();
				}
			}
			_menuList.length = 0;	
		}
		
		public static function showMenu(menu:ContextMenu, posX:Number = -999, posY:Number = -999):void {
			cleanMenu();
			adptMenu(menu);
			Laya._currentStage.addChild(menu);
			//menu.x=Laya.stage.mouseX;
			//menu.y=Laya.stage.mouseY;
			DisTools.showToStage(menu);
			if (posX != -999 && posY != -999) {
				menu.pos(posX, posY);
			}
			_menuList.push(menu);
		}
		
		/**创建菜单*/
		public static function createMenu(... args):ContextMenu {
			//return createMenuByArray(args);
			return createMenuByArray2(args);
		}
		
		/**创建菜单*/
		public static function createMenuByArray(args:Array):ContextMenu {
			//return null;
			var menu:ContextMenu = new ContextMenu();
			var separatorBefore:Boolean = false;
			var item:ContextMenuItem;
			for (var i:int = 0, n:int = args.length; i < n; i++) {
				var obj:Object = args[i];
				var info:Object = {};
				if (obj is String) {
					info.label = obj;
				} else {
					info = obj;
				}
				if (info.label != "") {
					item = new ContextMenuItem(info.label, separatorBefore);
					item.data = obj;
					menu.addItem(item);
					separatorBefore = false;
				} else {
					item = new ContextMenuItem("", separatorBefore);
					item.data = obj;
					menu.addItem(item);
					separatorBefore = true;
				}
			}
			return menu;
		}
		
		public static var revertLangDic:Object={};
		public static function getContextMenuLang(str:String):String
		{
			var langStr:String;
			langStr=Sys.lang(str);
			if(langStr!=str)
			{
				revertLangDic[langStr]=str;
			}
			return langStr;
	    }
		public static function revertMenuLang(str:String):String
		{
			if(revertLangDic[str]) return revertLangDic[str];
			return str;
	    }
		public var nativeMenu:*;
		public static const shortDic:Object={
			"转换为容器":"CmdOrCtrl+B",
			"转换类型":"CmdOrCtrl+T",
			"复制":"CmdOrCtrl+C",
			"剪切":"CmdOrCtrl+X",
			"粘贴":"CmdOrCtrl+V",
			"删除":"Delete",
			"打散容器":"CmdOrCtrl+U"
		};
		/**创建菜单*/
		public static function createMenuByArray2(args:Array):ContextMenu {
			var cmenu:ContextMenu = new ContextMenu();
			var template:Array = [];
			var tMenuStr:String;
			var tMenuO:Object;
			for (var j:int = 0, n:int = args.length; j < n; j++) {
				var item:* = args[j];
				if (item == "") {
					template.push({type: "separator"});
				} else if (item is Array) {
					var arr:Array = item as Array;
					
					
					var last:* = template[template.length-1];
					for (var k:int = 0; k < arr.length; k++) {
						tMenuStr=arr[k];
						if (arr[k] == "") {
							arr[k] = {type: "separator"};
						} else {
							tMenuO=arr[k] = {label: getContextMenuLang(arr[k]), click: click,preLabel:arr[k]};
							if(shortDic[tMenuStr])
							{
								tMenuO["accelerator"]=shortDic[tMenuStr];
							}
							
						}
					}
					last.submenu = arr;
				} else {
					tMenuStr=item;
					tMenuO={label: getContextMenuLang(item), click: click,preLabel:item};
					template.push(tMenuO);
					if(shortDic[tMenuStr])
					{
						tMenuO["accelerator"]=shortDic[tMenuStr];
					}
				}
			}
			function click(item:Object, focusedWindow:*):void {
				cmenu.event(Event.SELECT, item.preLabel);
			}
			if (SystemSetting.isCMDVer) return null;
			var menu:*;
			//__JS__('const {remote} = require("electron")');
			//__JS__('const {Menu, MenuItem} = remote');
			//__JS__("menu = Menu.buildFromTemplate(template)");
			__JS__('const remote = require("electron").remote;');
			__JS__('const Menu = remote.Menu;');
				__JS__('const MenuItem = remote.MenuItem');
			
			__JS__("menu = Menu.buildFromTemplate(template)");
			cmenu.nativeMenu = menu;
			return cmenu;
		}
		
		public static function adptMenu(menu:ContextMenu):void {
			var tWidth:Number = 80;
			var maxWidth:Number = 80;
			var i:int, len:int = menu.numChildren;
			for (i = 0; i < len; i++) {
				tWidth = (menu.getChildAt(i) as Sprite).width;
				if (maxWidth < tWidth) {
					maxWidth = tWidth;
				}
			}
			for (i = 0; i < len; i++) {
				(menu.getChildAt(i) as Sprite).width = maxWidth;
				
			}
		}
		private var _tY:Number = 0;
		
		public function addItem(item:ContextMenuItem):void {
			addChild(item);
			item.y = _tY;
			_tY += item.height;
			
			item.on(Event.MOUSE_DOWN, this, onClick);
		
		}
		
		private function onClick(e:Event):void {
			//trace("ContextMenu:",e);
			//event(Event.SELECT, e);
			event(Event.SELECT, e.target.name);
			removeSelf();
		}
		
		public function show(posX:Number = -999, posY:Number = -999):void {
			showMenu(this, posX, posY);
			//Laya.timer.once(50, this, nativeMenu.popup, [Laya.stage.mouseX, Laya.stage.mouseY]);
			//nativeMenu.popup(Laya.stage.mouseX, Laya.stage.mouseY);
		}	
	}
}