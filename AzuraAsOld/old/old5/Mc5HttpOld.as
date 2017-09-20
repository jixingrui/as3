package azura.gallerid3.source
{
	import azura.common.algorithm.crypto.MC5;
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	import azura.common.loaders.GreenSockLoader;
	import azura.common.loaders.HttpLoader;
	import azura.gallerid3.i.CancelableI;
	import azura.gallerid3.Gallerid;
	import azura.gallerid3.i.Mc5ConfigI;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Mc5HttpOld implements CancelableI
	{
		private static var mc5t:String;
		private static var mc5s:String;
		private static var mc5m:String;
		private static var mc5l:String;
		private static var mc5x:String;
		
		public static function set config(c:Mc5ConfigI):void{
			mc5t=c.mc5t;
			mc5s=c.mc5s;
			mc5m=c.mc5m;
			mc5l=c.mc5l;
			mc5x=c.mc5x;
		}
		
		private static var me_me:Dictionary=new Dictionary();
		
		public static function download(mc5:String,ret_ZintBuffer:Function):CancelableI{
			var url:String;
			var size:String=MC5.getSize(mc5);
			switch(size)
			{
				case "t":
				{
					url=mc5t+"/"+mc5;
					break;
				}
				case "s":
				{
					url=mc5s+"/"+mc5;
					break;
				}
				case "m":
				{
					url=mc5m+"/"+mc5;
					break;
				}
				case "l":
				{
					url=mc5l+"/"+mc5;
					break;
				}
				case "x":
				{
					url=mc5x+"/"+mc5;
					break;
				}
			}
			var me:Mc5HttpOld=new Mc5HttpOld(mc5,ret_ZintBuffer);
			me_me[me]=me;
			
			me.loader=GreenSockLoader.load(url,me.onDownloadComplete);
			
			return me;
		}
		
		private var loader:CancelableI;
		private var ret:Function;
		private var mc5:String;
		
		public function Mc5HttpOld(mc5:String,ret:Function){
			this.mc5=mc5;
			this.ret=ret;
		}
		
		public function onDownloadComplete(cypher:ByteArray):void{
			delete me_me[this];
			var plain:ZintBuffer=Gallerid.singleton().cache(mc5,cypher);
			ret.call(null,plain);
		}
		
		public function cancel():void{
			loader.cancel();
		}
	}
}