/**Created by the LayaAirIDE,do not modify.*/
package ui.easyviews {
	import laya.ui.*;
	import laya.display.*; 

	public class FoldersViewUI extends View {
		public var freshBtn:Button;
		public var saveBtn:Button;
		public var closeSameBtn:Button;
		public var folderTree:Tree;
		public var closeAllBtn:Button;
		public var recoverBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":445,"height":400},"child":[{"type":"Button","props":{"y":12,"x":20,"var":"freshBtn","skin":"comp/button.png","label":"刷新"}},{"type":"Button","props":{"y":12,"x":261,"var":"saveBtn","skin":"comp/button.png","label":"保存"}},{"type":"Button","props":{"y":13,"x":95,"var":"closeSameBtn","skin":"comp/button.png","label":"关闭重复"}},{"type":"Tree","props":{"x":24,"width":414,"var":"folderTree","top":60,"scrollBarSkin":"comp/vscroll.png","bottom":10},"child":[{"type":"Box","props":{"right":0,"renderType":"render","left":0},"child":[{"type":"Label","props":{"width":98,"text":"label","name":"label","height":21,"color":"#d2201d"}}]}]},{"type":"Button","props":{"y":13,"x":181,"var":"closeAllBtn","skin":"comp/button.png","label":"全部关闭"}},{"type":"Button","props":{"y":12,"x":336,"var":"recoverBtn","skin":"comp/button.png","label":"恢复"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}