package azura.gallerid3.source
{
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.collections.Mc5QueCache;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.Gallerid;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class GsFile
	{
		private static var packList:Vector.<GsFile>=new Vector.<GsFile>();
		
		private var file:File;
		private var size:int=0;
		
		public var master:String;
		
		internal var mc5_pos:Dictionary=new Dictionary();
		
//		private var memCache:Mc5QueCache=Mc5QueCache.singleton();
		
		public function GsFile(file:File=null):void
		{
			if(file!=null)
				fromFile(file);
			
			packList.push(this);
		}
		
		public function getMaster():ZintBuffer{
			return getSyncSingle(master);
		}
		
		private function openStream():FileStream{
			var fileStream:FileStream=new FileStream();
			fileStream.open(file,FileMode.READ);
			return fileStream;			
		}
		
		public function dispose():void{
			file=null;
			master=null;
			mc5_pos=null;
			
			var idx:int=packList.indexOf(this);
			packList.splice(idx,1);
		}
		
		public function fromFile(file:File):void{
			this.file=file;
			
			var fileStream:FileStream=openStream();
			size=fileStream.readInt();
			var nextStart:int=fileStream.position;
			
			for(var i:int=0;i<size;i++){
				fileStream.position=nextStart;
				
				var mc5:String=fileStream.readUTF();
				if(master==null)
					master=mc5;
				
				if(mc5.length==42){
					mc5_pos[mc5]=fileStream.position;
				}else{
					trace("file contains empty mc5:"+i);
				}
				
				var length:int=fileStream.readInt();
				nextStart=fileStream.position+length;
			}
			fileStream.close();
			
		}
		
		public static function getSync(mc5:String):ZintBuffer
		{
			var zb:ZintBuffer=Mc5QueCache.singleton().getData(mc5);
			if(zb!=null){
				zb.position=0;				
				return zb;
			}
			
			for each(var pack:GsFile in packList){
				zb=pack.getSyncSingle(mc5);
				if(zb!=null)
					return zb;
			}
			return null;
		}
		
		public function getSyncSingle(mc5:String):ZintBuffer
		{
			var pos:Number=mc5_pos[mc5];
			if(isNaN(pos))
				return null;
			
			var fileStream:FileStream=openStream();
			fileStream.position=pos;
			var length:int=fileStream.readInt();
			
			var result:ZintBuffer=new ZintBuffer();
			fileStream.readBytes(result,0,length);
			fileStream.close();
			
			Mc5QueCache.singleton().cache(mc5,result);
			
			return result;
		}
	}
}