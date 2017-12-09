/**Created by the LayaAirIDE,do not modify.*/
package ui.easyviews {
	import laya.ui.*;
	import laya.display.*; 
	import easyviews.FoldersView;
	import easyviews.ManagerView;

	public class EasyMainUI extends View {
		public var typeSelect:Tab;
		public var folderView:FoldersView;
		public var managerView:ManagerView;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":445,"height":400},"child":[{"type":"Tab","props":{"y":74,"x":3,"width":70,"var":"typeSelect","skin":"comp/tab.png","selectedIndex":0,"labels":"当前,管理","height":171,"direction":"vertical"}},{"type":"FoldersView","props":{"x":79,"var":"folderView","top":5,"runtime":"easyviews.FoldersView","bottom":10}},{"type":"ManagerView","props":{"x":97,"var":"managerView","top":5,"runtime":"easyviews.ManagerView","bottom":10}}]};
		override protected function createChildren():void {
			View.regComponent("easyviews.FoldersView",FoldersView);
			View.regComponent("easyviews.ManagerView",ManagerView);
			super.createChildren();
			createView(uiView);

		}

	}
}