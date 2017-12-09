/**Created by the LayaAirIDE,do not modify.*/
package ui.test {
	import laya.ui.*;
	import laya.display.*; 

	public class TestPageUI extends View {
		public var btn:Button;
		public var clip:Clip;
		public var combobox:ComboBox;
		public var tab:Tab;
		public var list:List;
		public var btn2:Button;
		public var check:CheckBox;
		public var radio:RadioGroup;
		public var box:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":838,"height":506},"child":[{"type":"Image","props":{"y":0,"x":0,"width":908,"skin":"comp/bg.png","sizeGrid":"30,4,4,4","height":666}},{"type":"Button","props":{"y":56,"x":41,"width":150,"var":"btn","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"点我赋值","height":37}},{"type":"Clip","props":{"y":56,"x":401,"var":"clip","skin":"comp/clip_num.png","clipX":10}},{"type":"ComboBox","props":{"y":143,"x":220,"width":200,"var":"combobox","skin":"comp/combobox.png","sizeGrid":"4,20,4,4","selectedIndex":1,"labels":"select1,select2,selecte3","height":23}},{"type":"Tab","props":{"y":96,"x":220,"var":"tab","skin":"comp/tab.png","labels":"tab1,tab2,tab3"}},{"type":"VScrollBar","props":{"y":223,"x":259,"skin":"comp/vscroll.png","height":150}},{"type":"VSlider","props":{"y":223,"x":224,"skin":"comp/vslider.png","height":150}},{"type":"List","props":{"y":68,"x":452,"width":128,"var":"list","vScrollBarSkin":"comp/vscroll.png","repeatX":1,"height":299},"child":[{"type":"Box","props":{"y":0,"x":0,"width":112,"name":"render","height":30},"child":[{"type":"Label","props":{"y":5,"x":26,"width":78,"text":"this is a list","skin":"comp/label.png","name":"label","height":20,"fontSize":14}},{"type":"Clip","props":{"y":2,"x":0,"skin":"comp/clip_num.png","name":"clip","clipX":10}}]}]},{"type":"Button","props":{"y":4,"x":563,"skin":"comp/btn_close.png","name":"close"}},{"type":"Button","props":{"y":112,"x":41,"width":150,"var":"btn2","skin":"comp/button.png","sizeGrid":"4,4,4,4","labelSize":30,"labelBold":true,"label":"点我赋值","height":66}},{"type":"CheckBox","props":{"y":188,"x":220,"var":"check","skin":"comp/checkbox.png","label":"checkBox1"}},{"type":"RadioGroup","props":{"y":61,"x":220,"var":"radio","skin":"comp/radiogroup.png","labels":"radio1,radio2,radio3"}},{"type":"Panel","props":{"y":223,"x":299,"width":127,"vScrollBarSkin":"comp/vscroll.png","height":150},"child":[{"type":"Image","props":{"skin":"comp/image.png"}}]},{"type":"CheckBox","props":{"y":188,"x":326,"skin":"comp/checkbox.png","labelColors":"#ff0000","label":"checkBox2"}},{"type":"Box","props":{"y":197,"x":41,"var":"box"},"child":[{"type":"ProgressBar","props":{"y":70,"width":150,"skin":"comp/progress.png","sizeGrid":"4,4,4,4","name":"progress","height":14}},{"type":"Label","props":{"y":103,"width":137,"text":"This is a Label","skin":"comp/label.png","name":"label","height":26,"fontSize":20}},{"type":"TextInput","props":{"y":148,"width":150,"text":"textinput","skin":"comp/textinput.png","name":"input"}},{"type":"HSlider","props":{"width":150,"skin":"comp/hslider.png","name":"slider"}},{"type":"HScrollBar","props":{"y":34,"width":150,"skin":"comp/hscroll.png","name":"scroll"}}]},{"type":"Animation","props":{"y":341,"x":94,"source":"anis/SimpleAnimation.ani","autoPlay":true}},{"type":"Animation","props":{"y":521,"x":648,"source":"anis/SwitchPicAnimation.ani","autoPlay":true}},{"type":"Animation","props":{"y":297,"x":758,"source":"anis/hero1Ani.ani","autoAnimation":"attack"}},{"type":"Animation","props":{"y":268,"x":652,"source":"anis/hero1Ani1.ani","autoAnimation":"attack"}},{"type":"Animation","props":{"y":604,"x":527,"source":"anis/DH_guai1.ani","autoPlay":true}},{"type":"Image","props":{"y":463,"x":303,"width":152,"skin":"comp/hslider.png","height":110}},{"type":"Label","props":{"y":513,"x":328,"width":107,"text":"label","height":46,"fontSize":30,"font":"BFont"}},{"type":"Image","props":{"y":374,"x":621,"width":221,"skin":"comp/bg.png","height":131},"child":[{"type":"Image","props":{"y":-26,"x":-22,"width":82,"skin":"comp/image.png","renderType":"mask","height":145}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}