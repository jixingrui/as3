package azura.gallerid.gal
{
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class FileStreamSource implements GalleridIOld
	{
		private var fileStream:FileStream;		
		private var _mc5List:Vector.<String>=new Vector.<String>();
		private var mc5_pos:Dictionary=new Dictionary();

		public function open(file:File):void
		{
			fileStream=new FileStream();
			fileStream.open(file,FileMode.READ);
			readGp();
		}
		
		public function close():void{
			fileStream.close();
		}
		
		private function readGp():void{
			
			var size:int=fileStream.readInt();
			var nextStart:int=fileStream.position;
			
			for(var i:int=0;i<size;i++){
				fileStream.position=nextStart;
				
				var mc5:String=fileStream.readUTF();
				mc5List.push(mc5);
				mc5_pos[mc5]=fileStream.position;
				
				var length:int=fileStream.readInt();
				nextStart=fileStream.position+length;
			}
		}
		
		public function get mc5List():Vector.<String>
		{
			return _mc5List;
		}
		
		public function getData(mc5:String, ret_ByteArray:Function):void
		{
			if(mc5_pos[mc5]!=null){
				ret_ByteArray.call(null,getDataSync(mc5));
			}
		}
		
		public function getDataSync(mc5:String):ByteArray{
			fileStream.position=mc5_pos[mc5];
			var length:int=fileStream.readInt();
			
			var result:ByteArray=new ByteArray();
			fileStream.readBytes(result,0,length);
			return result;
		}
	}
}