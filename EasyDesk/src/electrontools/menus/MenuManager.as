///////////////////////////////////////////////////////////
//  MenuManager.as
//  Macromedia ActionScript Implementation of the Class MenuManager
//  Created on:      2016-6-23 下午2:33:23
//  Original author: ww
///////////////////////////////////////////////////////////

package electrontools.menus
{
	import laya.events.Event;
	
	/**
	 * 
	 * @author ww
	 * @version 1.0
	 * 
	 * @created  2016-6-23 下午2:33:23
	 */
	public class MenuManager
	{
		public function MenuManager()
		{
		}
		
		private static var _menuDic:Object={};
		public static function showMenu(menuStr:String,thisO:Object,fun:Function):void
		{
			var tMenu:ContextMenu;
			if(!_menuDic[menuStr])
			{
				tMenu=ContextMenu.createMenuByArray(menuStr.split(","));
				//tMenu=ContextMenu.createMenuByArray2(menuStr.split(","));
				_menuDic[menuStr]=tMenu;
			}
			tMenu=_menuDic[menuStr];
			tMenu.offAll(Event.SELECT);
			tMenu.once(Event.SELECT,thisO,fun);
			tMenu.show();
		}
	}
}