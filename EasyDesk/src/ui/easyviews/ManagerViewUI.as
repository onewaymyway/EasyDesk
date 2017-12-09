/**Created by the LayaAirIDE,do not modify.*/
package ui.easyviews {
	import laya.ui.*;
	import laya.display.*; 

	public class ManagerViewUI extends View {
		public var typeList:List;
		public var folderList:List;
		public var freshBtn:Button;
		public var addBtn:Button;
		public var saveBtn:Button;
		public var typeInput:TextInput;
		public var foldersTitle:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":445,"height":400},"child":[{"type":"List","props":{"x":21,"width":126,"var":"typeList","vScrollBarSkin":"comp/vscroll.png","top":60,"scrollBarSkin":"comp/vscroll.png","repeatX":1,"height":290,"bottom":50},"child":[{"type":"Box","props":{"renderType":"render"},"child":[{"type":"Label","props":{"width":98,"text":"label","name":"label","height":21,"color":"#d2201d"}}]}]},{"type":"List","props":{"x":188,"width":344,"var":"folderList","vScrollBarSkin":"comp/vscroll.png","top":62,"scrollBarSkin":"comp/vscroll.png","repeatX":1,"bottom":40},"child":[{"type":"Box","props":{"right":0,"renderType":"render","left":0},"child":[{"type":"Label","props":{"width":98,"text":"label","name":"label","height":21,"color":"#d2201d"}}]}]},{"type":"Button","props":{"y":10,"x":21,"var":"freshBtn","skin":"comp/button.png","label":"刷新"}},{"type":"Button","props":{"x":125,"var":"addBtn","skin":"comp/button.png","label":"添加","bottom":5}},{"type":"Button","props":{"y":10,"x":99,"var":"saveBtn","skin":"comp/button.png","label":"保存"}},{"type":"TextInput","props":{"x":2,"width":114,"var":"typeInput","skin":"comp/input_22.png","height":22,"color":"#e7c8c8","bottom":5}},{"type":"Label","props":{"y":38,"x":24,"width":97,"text":"Types","height":19,"color":"#3e70bb"}},{"type":"Label","props":{"y":37,"x":188,"width":97,"var":"foldersTitle","text":"Folders","height":19,"color":"#3e70bb"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}