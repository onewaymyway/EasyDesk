package easyviews 
{
	import laya.utils.Handler;
	import ui.easyviews.EasyMainUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class EasyMain extends EasyMainUI 
	{
		private var views:Array;
		public function EasyMain() 
		{
			views = [folderView, managerView];
			typeSelect.selectHandler = new Handler(this, updateSelect);
			updateSelect();
		}
		private function updateSelect():void
		{
			var i:int, len:int;
			len = views.length;
			var tV:Sprite;
			for (i = 0; i < len; i++)
			{
				tV = views[i];
				if (i != typeSelect.selectedIndex)
				{
					tV.visible = false;
					tV.removeSelf();
				}else
				{
					tV.visible = true;
					addChild(tV);
				}
			}
		}
	}

}