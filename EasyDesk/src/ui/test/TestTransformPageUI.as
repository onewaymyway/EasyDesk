/**Created by the LayaAirIDE,do not modify.*/
package ui.test {
	import laya.ui.*;
	import laya.display.*; 

	public class TestTransformPageUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":445,"height":400},"child":[{"type":"Image","props":{"top":0,"skin":"comp/bg.png","right":0,"left":0,"bottom":0}},{"type":"Image","props":{"y":34,"x":130,"skin":"comp/image.png","rotation":23}},{"type":"Image","props":{"y":103,"x":281,"skin":"comp/image.png","scaleY":0.5,"scaleX":0.5,"alpha":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}