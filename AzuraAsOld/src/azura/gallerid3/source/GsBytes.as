package azura.gallerid3.source
{
	import azura.gallerid3.Gallerid;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class GsBytes
	{
//		public var master:String;
//		private var data:ByteArray;
		
//		private var mc5_data:Dictionary=new Dictionary();
		
		public static function fromBytes(ba:ByteArray):String
		{
//			data=ba;
			
			var master:String;
			
			var mc5_pos:Dictionary=new Dictionary();
			
			var size:int =ba.readInt();
			var nextStart:int=ba.position;
			
			for(var i:int=0;i<size;i++){
				ba.position=nextStart;
				
				var mc5:String=ba.readUTF();
				if(master==null){
					master=mc5;
					if(Gallerid.singleton().mem.getData(master)!=null){
						return master;
					}
				}
				
				if(mc5.length==42){
					mc5_pos[mc5]=ba.position;
				}else{
					trace("file contains empty mc5:"+i);
				}
				
				var length:int=ba.readInt();
				nextStart=ba.position+length;
			}
			
			for(mc5 in mc5_pos){
				var pos:int=mc5_pos[mc5];
				ba.position=pos;
				length=ba.readInt();
				var data:ByteArray=new ByteArray();
				ba.readBytes(data,0,length);
				
				Gallerid.singleton().cacheMem(mc5,data);
			}
			
			return master;
		}
		
	}
}