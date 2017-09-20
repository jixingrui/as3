package azura.gallerid3
{
	import azura.common.async2.AsyncLoader2;
	import azura.common.async2.AsyncLoader2I;
	import azura.common.loaders.GreenSockLoader;
	import azura.gallerid3.i.Mc5ConfigI;
	
	import flash.utils.ByteArray;
	
	public class Mc5Http extends AsyncLoader2 implements AsyncLoader2I
	{
		public static var config:Mc5ConfigI;
		
		public function Mc5Http(mc5:String)
		{
			super(mc5);
		}
		
		public function get mc5():String{
			return key as String;
		}
		
		override public function process():void
		{
			var url:String=config.mc5ToUrl(mc5);
			GreenSockLoader.load(url,onComplete);
			
			function onComplete(ba:ByteArray):void{
				submit(ba);
			}
		}
		
		override public function dispose():void
		{
		}
	}
}