package electrontools
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Rectangle;
	import laya.ui.TextInput;
	
	import laya.debug.tools.ObjectTools;
	import laya.debug.tools.TraceTool;
	
	/**
	 * 显示对象常用的工具类
	 * @author ww
	 */
	public class DisTools
	{
		
		public function DisTools()
		{
		
		}
		
		/**
		 * 将对象显示到Stage上 
		 * @param dis
		 * @param offX
		 * @param offY
		 * 
		 */
		public static function showToStage(dis:Sprite, offX:int = 0, offY:int = 0):void
		{
			var rec:Rectangle = dis.getBounds();
			dis.x = Laya.stage.mouseX + offX;
			dis.y = Laya.stage.mouseY + offY;
			if (dis.x + rec.width > Laya.stage.width)
			{
				dis.x -= rec.width + offX;
			}
			if (dis.y + rec.height > Laya.stage.height)
			{
				dis.y -= rec.height + offY;
					//dis.y -= 100;
			}
		}
		/**
		 * 将子对象显示到父容器中间 
		 * @param dis
		 * @param parent
		 * 
		 */
		public static function showToCenter(dis:Sprite, parent:Sprite):void
		{
			dis.x = 0.5 * (parent.width - dis.width);
			dis.y = 0.5 * (parent.height - dis.height);
			parent.addChild(dis);
		}
		public static function getDisDesO(dis:Sprite):Object
		{
			if (!dis)
				return null;
			var rst:Object = {};
			if(dis.name)
			{
				rst.label = TraceTool.getClassName(dis) + "(" + dis.name+")";
			}else
			{
				rst.label = TraceTool.getClassName(dis) ;
			}
			
			if(dis["comXml"])
			{
				rst.compId=dis["comXml"]["compId"];
			}
			rst.path = dis;
			
			rst.files = [];
			rst.dirs = [];
			rst.childs = [];
			rst.isDirectory = true;
			
			return rst;
		}
		
		public static function getDisTreeArr(sp:Sprite,filterFun:Function=null):Array
		{
			var tTreeO:Object = getDisTreeO(sp,filterFun);
			var rst:Array = [];
			getTreeArr(tTreeO, rst);
			return rst;
		
		}
		
		public static function getTreeArr(treeO:Object, arr:Array,filterFun:Function=null):void
		{
			arr.push(treeO);
			var tArr:Array = treeO.childs||treeO.child;
			var i:int, len:int = tArr.length;
			for (i = 0; i < len; i++)
			{

				if (tArr[i].isDirectory)
				{
					getTreeArr(tArr[i], arr);
				}
				else
				{
					arr.push(tArr[i]);
				}
			}
		}
		
		public static function getDisTreeO(dis:Sprite,filterFun:Function=null):Object
		{
			var rst:Object = getDisDesO(dis);
			

			var i:int, len:int;
			var tChild:Sprite;
			var tO:Object;
			len = dis.numChildren;
			for (i = 0; i < len; i++)
			{
				tChild = dis.getChildAt(i) as Sprite;
				if(filterFun!=null&&!filterFun(tChild))
				{
					//trace("skip dis by filter:",tChild);
					continue;
				}
				tO = getDisTreeO(tChild,filterFun);
				tO.nodeParent = rst;
				tO.hasChild = tO.childs.length > 0;
				tO.isDirectory=tO.hasChild;
				rst.dirs.push(tO);
				rst.childs.push(tO);
			}

			rst.hasChild = rst.childs.length > 0;
				
			
			return rst;
		
		}
		
		public static function addTextChangeHandler(input:TextInput,_this:Object,fun:Function,param:Array=null):void
		{
			input.on(Event.ENTER, _this, fun);
			input.on(Event.BLUR, _this, fun);
		}
	}

}