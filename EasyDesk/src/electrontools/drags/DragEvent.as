package electrontools.drags {
	import laya.events.Event;
	import nodetools.devices.FileManager;
	import nodetools.devices.FileTools;

	
	/**拖动事件类*/
	public class DragEvent extends Event {
		public static const DRAG_START:String = "dragStart";
		public static const DRAG_DROP:String = "dragDrop";
		public static const Draging_Hit:String="Draging_Hit";
		public static const DRAG_COMPLETE:String = "dragComplete";
		public static const DRAG_MOVE:String = "dragMove";
		
		public static const Res:String="res";
		public static const ResDir:String="resDir";
		public static const Props:String="Props";
		public static const MULTI_RESFILE:String="multiResFile";
		public static const DisplayDrag:String="displayDrag";
		
		public static const SystemDrag:String="SystemDrag";
		
		public static const Page:String="page";
		public static const PageDir:String="pageDir";
		public static const MULTI_PAGEFILE:String="multiPageFile";
		
		protected var _data:*;
		protected var _dragInitiator:*;
		
		public static var TEMP:DragEvent = new DragEvent(DRAG_DROP);
		
		public function DragEvent(type:String, dragInitiator:* = null, data:* = null, bubbles:Boolean = true, cancelable:Boolean = false) {
		//	super(type, bubbles, cancelable);
			this.type=type;
			_dragInitiator = dragInitiator;
			_data = data;
		}
		
		/**拖动的源对象*/
		public function get dragInitiator():* {
			return _dragInitiator;
		}
		
		public function set dragInitiator(value:*):void {
			_dragInitiator = value;
		}
		
		/**拖动传递的数据*/
		public function get data():* {
			return _data;
		}
		
		public function set data(value:*):void {
			_data = value;
		}
		public var hitList:Array;
		public function clone():Event {
			return new DragEvent(type, _dragInitiator, _data);
		}
		
		public static function getMutiDragFiles(e:DragEvent):Array
		{
			var data:Object = e.data;
			
			
			if(data.type!=DragEvent.MULTI_RESFILE&&data.type!=DragEvent.ResDir)
			{
                return null;
			} 
			var src:*= e.dragInitiator;
			//			trace("onDragDrop:", tar, src, data);
			var fileList:Array;
			fileList=data.fileList;
			if(data.type==DragEvent.ResDir)
			{
				fileList=FileTools.getFileList(data.asset);
			}
			var i:int,len:int;
			len=fileList.length;
			var files:Array;
			files=[];
			for(i=0;i<len;i++)
			{
				var path:String;
				path= fileList[i];
				if(FileTools.isDirectory(path)) continue;
				path = FileManager.getRelativePath(SystemSetting.assetsPath, path);
				path=FileManager.adptToCommonUrl(path);
				files.push(path);
			}
			files.sort();
			return files;
		}
	}
}