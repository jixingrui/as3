package azura.gallerid4
{
	import azura.common.algorithm.crypto.MC5;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class Gal4
	{
		private static var strongHold:Dictionary=new Dictionary();
		
		public static var mem:Gal4Mem=new Gal4Mem();
		public static var file:Gal4Storage=new Gal4Storage();
		
		public var mc5:String;
		public var data:ZintBuffer;
		private var ret:Function;
		
		public function Gal4(mc5:String,ret:Function){
			this.mc5=mc5;
			this.ret=ret;
			strongHold[this]=true;
		}
		
		internal function ready():void{
			delete strongHold[this];
			ret.call(null,this);
		}
		
		public static function writeOne(plain:ByteArray):String{
			var mc5:String=MC5.hash(plain);
			mem.write(mc5,plain);
			file.write(mc5,plain,true,true);
			return mc5;
		}
		
		public static function write(mc5:String,raw:ByteArray,plain_cypher:Boolean,flush:Boolean):void{
			if(plain_cypher){
				mem.write(mc5,raw);
				file.write(mc5,raw,true,flush);
			}else{
				var plain:ByteArray=file.write(mc5,raw,false,flush);
				mem.write(mc5,plain);
			}
//			trace("Gal4: wrote",mc5);
		}
		
		public static function flushFileState():void{
			file.flush();
		}
		
		public static function contains(mc5:String):Boolean{
			return file.contains(mc5);
		}
		
		public static function readSync(mc5:String):ZintBuffer{
						
			var data:ByteArray=mem.read(mc5);
			if(data!=null)
				return new ZintBuffer(data);
			
			data= file.readSync(mc5);
			if(data!=null){
				mem.write(mc5,data);
				return new ZintBuffer(data);
			}
			
			return null;
		}
		
		public static function readAsync(mc5:String,ret_Gal4:Function):void{
			
			var result:Gal4=new Gal4(mc5,ret_Gal4);
			
			var data:ByteArray=mem.read(mc5);
			if(data!=null){
				result.data=new ZintBuffer(data);
				result.ready();
				return;
			}
			
			if(file.contains(mc5)){
				file.readAsync(result);
				return;
			}
			
			trace("Gal4: mc5 not found",mc5);
			//			Gal4Http.read(result);
		}
		
//		public static function isCached(path:String):Boolean{
//			var gp:Gal4Pack=new Gal4Pack();
//			return gp.isCached(path);
//		}
//		
		
//		public static function loadFrom(path:String):String{
//			var gp:Gal4Pack=new Gal4Pack();
//			return gp.loadFromPath(path);
//		}
		
		public static function clear():void{
			mem.clear();
			file.clear();
		}
	}
}
