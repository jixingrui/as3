package azura.gallerid
{
	import common.algorithm.crypto.MD5;
	import common.algorithm.crypto.Rot;
	import common.async.AsyncBoxI;
	import common.async.AsyncQue;
	import common.async.AsyncTask;
	import common.async.AsyncUserA;
	
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	public class Gal_File extends AsyncUserA
	{		
		{
			SharedObject.getLocal("diskspace").flush(100000000);
			AsyncQue.configParallel("file",120000,0,1);
		}
		
		private static var fileCount:int;
		
		public static function load(md5:String,ret_ByteArray:Function):void{
			fileCount++;
//			trace("file count="+fileCount+" "+md5);
			var user:Gal_File=new Gal_File(md5,ret_ByteArray);
			AsyncQue.enque("file",user);
		}
		
		private var ret_ByteArray:Function;
		
		function Gal_File(md5:String,ret_ByteArray:Function){
			super(md5);
			this.ret_ByteArray=ret_ByteArray;
			if(md5==null||md5.length!=32)
				throw new Error("Gal_File: empty request");
		}
		
		override public function process(answer:AsyncTask):void
		{
			var md5:String=key as String;
			var data:ByteArray=Gal_File.getData(md5);
			var box:ByteArrayBox=new ByteArrayBox();
			box.ba=data;
			answer.submit(box);
			fileCount--;
//			trace("file count="+fileCount+" "+key+" submitted isNull="+(data==null));
		}
		
		override public function ready(value:AsyncBoxI):void
		{
			var box:ByteArrayBox=value as ByteArrayBox;
			ret_ByteArray.call(null,box.ba);
			
			super.discard();
			
//			trace("file count="+fileCount+" "+key+" served isNull="+(box.ba==null));
		}
		
		public static function put(data:ByteArray):String{
			var md5:String=MD5.b2s(data);
			var cypher:ByteArray=Rot.process(data,true);
			putDirect(md5,cypher);
			return md5;
		}
		
		internal static function putDirect(md5:String,cypher:ByteArray):void{
			var so:SharedObject=SharedObject.getLocal(md5);
			var ba:ByteArray=new ByteArray();
			ba.writeBytes(cypher);
			ba.position=0;
			cypher.position=0;
			so.data.byteArray=ba;
			so.flush();
		}
		
		public static function getData(md5:String):ByteArray{
			var data:ByteArray=Gal_Memory.getData(md5);
			if(data!=null)
				return data;
			
			var cypher:ByteArray=getDirect(md5);
			if(cypher==null)
				return null;
			
			return Rot.process(cypher,false);
		}
		
		private static function getDirect(md5:String):ByteArray{
			var so:SharedObject=SharedObject.getLocal(md5);
			var cypher:ByteArray= so.data.byteArray;
			so.close();
			return cypher;
		}
	}
}
