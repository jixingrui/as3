package azura.banshee.layers.zpano
{
	import azura.common.async2.AsyncLoader2;
	import azura.common.async2.AsyncLoader2I;
	import azura.common.loaders.BitmapDataLoader;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	public class ZpanoLoader extends AsyncLoader2 implements AsyncLoader2I
	{
		public var direction:int;
		private var jpg:ByteArray;
		public function ZpanoLoader(mc5:String,direction:int,jpg:ByteArray)
		{
			super(mc5+direction);
			this.direction=direction;
			this.jpg=jpg;
		}
		
		override public function process():void
		{
			BitmapDataLoader.load(onReady,jpg);
			function onReady(bd:BitmapData):void{
				submit(bd);
//				setTimeout(submit,1000,bd);
			}
		}
		
		override public function dispose():void
		{
		}
	}
}