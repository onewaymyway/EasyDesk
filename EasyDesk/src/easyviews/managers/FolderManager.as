package easyviews.managers 
{
	import nodetools.devices.FileManager;
	import nodetools.devices.Paths;
	/**
	 * ...
	 * @author ww
	 */
	public class FolderManager 
	{
		
		public function FolderManager() 
		{
			
		}
		public static var tFolderO:Object;
		public static function getFolderFilePath():String
		{
			return FileManager.getPath(Paths.dataPath, "folder.json");
		}
		public static function getTypes():Array
		{
			return tFolderO.types;
		}
		public static function createDefaultFolderData():Object
		{
			var rst:Object;
			rst = { };
			rst.types = [];
			rst.fileConfig = { };
			return rst;
		}
		public static function loadFolderFile():Object
		{
			var rst:Object;
			if (!FileManager.exists(getFolderFilePath()))
			{
				rst=createDefaultFolderData();
			}else
			{
				rst=FileManager.readJSONFile(getFolderFilePath());
			}
			tFolderO = rst;
			return rst;
		}
		
		public static function saveFolderFile():void
		{
			if(tFolderO)
			FileManager.createJSONFile(getFolderFilePath(),tFolderO);
		}
		
		public static function createTypeO(type:String):Object
		{
			var rst:Object;
			rst = { };
			rst.type = type;
			rst.files = [];
			return rst;
		}
		
		public static function findTypeO(type:String):Object
		{
			var typeList:Array;
			typeList = tFolderO.types;
			var i:int, len:int;
			len = typeList.length;
			var tTypeO:Object;
			for (i = 0; i < len; i++)
			{
				tTypeO = typeList[i];
				if (tTypeO.type == type) return tTypeO;
			}
			tTypeO = createTypeO(type);
			typeList.push(tTypeO);
			return tTypeO;
		}
		public static function addType(type:String):void
		{
			findTypeO(type);
		}
		public static function addFolderToType(type:String, folder:String):void
		{
			var typeO:Object;
			typeO = findTypeO(type);
			folder = FileManager.adptToCommonUrl(folder);
			var files:Array;
			files = typeO.files;
			if (files.indexOf(folder) < 0) files.push(folder);
		}
	}

}