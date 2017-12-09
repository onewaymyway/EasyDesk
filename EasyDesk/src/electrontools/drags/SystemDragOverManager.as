package electrontools.drags {
	import ide.managers.Notice;
	import laya.debug.tools.DisControlTool;
	import laya.display.Sprite;
	import laya.events.EventDispatcher;
	
	import laya.editor.core.events.DragEvent;
	import laya.editor.core.managers.DragManager;
	import laya.editor.manager.ProjectManager;
	import laya.events.Event;
	import laya.ide.consts.SkinDefines;
	import laya.ide.devices.FileTools;
	import laya.ide.event.IDEEvent;
	import laya.renders.Render;
	import laya.ui.Clip;
	import laya.utils.Browser;
	import laya.utils.Utils;
	
	/**
	 * ...
	 * @author ww
	 */
	public class SystemDragOverManager {
		
		public function SystemDragOverManager() {
		
		}
		
		public static function init():void {
			var canvas:* = Render.canvas;
			Browser.container.ondrop = dragDrop;
			Browser.container.ondragover = dragOver;

		}
		
		private static function dragOver(e:*):void {
			e.preventDefault();
		}
		
		public static function dragDrop(e:*):Boolean {
			trace("system dragover", e);
			var file:*;
			try {
				file = e.dataTransfer.files[0];
				onFileDrag(e.dataTransfer.files, e.clientX, e.clientY);
				e.preventDefault();
			}
			catch (e:*) {
			}
			
			return false;
		}
		
		public static const SystemDrag:String = "SystemDrag";
		private static function onFileDrag(files:Array, x:Number, y:Number):void {
			if (!files || files.length < 1)
				return;
			
			var data:Object;
			var type:String = SystemDrag;
			var files:Array;
			files = Utils.copyArray(files, []);
			data = {type: type, files: files};
//			Laya.timer.once(100,null,DragManager.sendDragEventByData,[DragEvent.DRAG_COMPLETE,data,data]);
			sendDragEventByData(SystemDrag, data, data, x, y);
		
		}
		
		private static var tempEvent:Object = { };
		public static function sendDragEventByData(type:String,_dragInitiator:*,_data:*,x:*="s",y:*="s"):void
		{
			if(x=="s")
			{
				x= Laya.stage.mouseX;
			}
			if(y=="s")
			{
				y= Laya.stage.mouseY;
			}
			var rst:Array;
			rst = DisControlTool.getObjectsUnderPoint(Laya.stage, x*Browser.pixelRatio, y*Browser.pixelRatio,null,DisControlTool.visibleAndEnableObjFun);
			//trace("hitTest:", rst);
			var i:int, len:int;
			var tTar:Sprite;
			len = rst.length;
			var tEvent:Object=tempEvent;
			tEvent.dragInitiator = _dragInitiator;
			tEvent.data = _data;
			tEvent.hitList = rst;
			for (i = 0; i < len; i++)
			{
				tTar = rst[i];
				if (tTar is EventDispatcher)
				{
					if (tTar.hasListener(type))
					{
						tEvent.target = tTar;
						//tTar.event(DragEvent.DRAG_DROP, [tTar, _dragInitiator, _data]);
						tTar.event(type, tEvent);
					}
				}
			}
		}
	}

}