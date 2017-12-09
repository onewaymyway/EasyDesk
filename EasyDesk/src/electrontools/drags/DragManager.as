package electrontools.drags {
	import laya.debug.tools.DisControlTool;
	import laya.display.Sprite;
	import laya.editor.core.Wraps.Keyboard;
	import laya.editor.core.events.DragEvent;
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.ide.managers.FocusManager;
	import laya.maths.Point;
	import laya.ui.Clip;
	import laya.utils.Browser;
	
	/**拖动管理类*/
	public class DragManager {
		private var _dragInitiator:Sprite;
		private var _dragImage:Sprite;
		private static var _data:*;
		public static var dragOffset:Point=new Point(7,7);
		public function DragManager() {
			Laya.stage.on(Event.KEY_DOWN,this,onStageKeyDown);
		}
		private function onStageKeyDown(e:Event):void
		{
			switch(e.keyCode)
			{
				case Keyboard.ESCAPE:
					Laya.stage.off(Event.MOUSE_MOVE,this, onStageMouseMove);
					Laya.stage.off(Event.MOUSE_UP,this, onStageMouseUp);
					clears();
					break;
			}
		}
		private var _offSet:Point=new Point();
		public static var isDraging:Boolean = false;
		/**开始拖动
		 * @param dragInitiator 拖动的源对象
		 * @param dragImage 显示拖动的图片，如果为null，则是源对象本身
		 * @param data 拖动传递的数据
		 * @param offset 鼠标居拖动图片的偏移*/
		public function doDrag(dragInitiator:Sprite, dragImage:Sprite = null, data:* = null, offset:Point = null):void {
//			trace("doDrag");
			//TODO:待优化
			clears();
			prePos.setTo(Laya.stage.mouseX, Laya.stage.mouseY);
			_dragInitiator = dragInitiator;
			_dragImage = dragImage ? dragImage : dragInitiator;
			if(_dragImage is Clip)
			{
				_dragImage.width*=0.5;
				_dragImage.height*=0.5;
			}
			
			_data = data || {};
			
			offset=null;
			if(offset)
			{
				_offSet.setTo(offset.x,offset.y);
			}else
			{
				_offSet.setTo(_dragImage.width*0.5,_dragImage.height*0.5);
			}
			if (_dragImage != _dragInitiator) {
				if (!_dragImage.parent) {
					Laya._currentStage.addChild(_dragImage);
				}
				
				offset = offset || new Point();
				var p:Point = _dragImage.globalToLocal(new Point(Laya.stage.mouseX, Laya.stage.mouseY));
				_dragImage.x = p.x - offset.x;
				_dragImage.y = p.y - offset.y;
				_dragImage.visible = false;
				_dragImage.mouseEnabled = false;
			}			
			Laya.stage.on(Event.MOUSE_MOVE,this, onStageMouseMove);
			Laya.stage.on(Event.MOUSE_UP, this,onStageMouseUp);
		}
		
		/**放置把拖动条拖出显示区域*/
		private function onStageMouseMove(e:Event):void {
			
			//trace("onStageMouseMove",Laya.stage.mouseX,Laya.stage.mouseY);
			//return;
			if (Math.abs(prePos.x - Laya.stage.mouseX) + Math.abs(prePos.y - Laya.stage.mouseY)<8)
			{
				return;
			}
			if(!_dragImage) return;
			if (!isDraging) {
//				trace("start drag");
				_dragImage.visible = true;
//				trace("startDrag");
				_dragImage.x=Laya.stage.mouseX-_offSet.x;
				_dragImage.y=Laya.stage.mouseY-_offSet.y;
				_dragImage.startDrag();
				_dragImage.on(Event.DRAG_MOVE,this,onDraging);
				_dragInitiator.event(DragEvent.DRAG_START, [ _dragInitiator, _data]);
				isDraging = true;
				_dragImage.mouseEnabled = false;
				
			}
			sendDragEvent(DragEvent.Draging_Hit);

		}
		private function onDraging():void
		{
			if(!_dragImage) return;
			_dragImage.x=Laya.stage.mouseX-_offSet.x;
			_dragImage.y=Laya.stage.mouseY-_offSet.y;
		}
		public static var prePos:Point = new Point();
		public static var dPos:Point = new Point();
		private function onStageMouseUp(e:Event):void {
			//return;
			Laya.stage.off(Event.MOUSE_MOVE,this, onStageMouseMove);
			Laya.stage.off(Event.MOUSE_UP,this, onStageMouseUp);
			//_dragImage.stopDrag();
//			trace("drag end");
			dPos.setTo(Laya.stage.mouseX-prePos.x,Laya.stage.mouseY-prePos.y);
			//prePos.setTo(Laya.stage.mouseX, Laya.stage.mouseY);
			if (Math.abs(prePos.x - Laya.stage.mouseX) + Math.abs(prePos.y - Laya.stage.mouseY)<8)
			{
				clears();
				return;
			}
			getTarList();
			if(!_dragInitiator) return;
			_dragInitiator.event(DragEvent.DRAG_COMPLETE,[ _dragInitiator, _data]);
			clears();
		}
		private function clears():void
		{
			if(_dragImage)
			{
				_dragImage.off(Event.DRAG_MOVE,this,onDraging);
				_dragImage.mouseEnabled=true;
				if(_dragImage!=_dragInitiator)
				_dragImage.removeSelf();
			}
			_dragInitiator = null;
			_data = null;
			_dragImage = null;
			isDraging = false;
			FocusManager.clearFocus();
		}
		public static function getDragType():String
		{
			if (!_data||!_data.type) return null;
			return _data.type;
		}
		public static function getDragTarget():*
		{
			if (!_data || !_data.target) return null;
			return _data.target;
		}
		private function sendDragEvent(type:String):void
		{
			getTarList(type);
		}
		private function getTarList(type:String="dragDrop"):void
		{
			sendDragEventByData(type,_dragInitiator,_data);
			return;
			var rst:Array;
			rst = DisControlTool.getObjectsUnderPoint(Laya.stage, Laya.stage.mouseX*Browser.pixelRatio, Laya.stage.mouseY*Browser.pixelRatio,null,DisControlTool.visibleAndEnableObjFun);
			//trace("hitTest:", rst);
			var i:int, len:int;
			var tTar:Sprite;
			len = rst.length;
			var tEvent:DragEvent=DragEvent.TEMP;
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
			var tEvent:DragEvent=DragEvent.TEMP;
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