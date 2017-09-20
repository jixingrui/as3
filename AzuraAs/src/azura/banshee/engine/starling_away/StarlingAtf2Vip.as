package azura.banshee.engine.starling_away
{
	import azura.common.async2.Async2;
	import azura.common.async2.AsyncLoader2;
	import azura.gallerid4.Gal4;
	
	import starling.textures.Texture;
	
	public class StarlingAtf2Vip extends StarlingAtf2
	{
		private static var initialized:Boolean=false;
		
		public static function init():void{
			if(initialized==false){
				initialized=true;
				Async2.newSequence(1).order(StarlingAtf2Vip).order(StarlingAtf2);
			}
		}
		
		public function StarlingAtf2Vip(mc5:String)
		{
			super(mc5);
		}
		
		override protected function loadDelay(g:Gal4):void{
			loadAsync(g);
		}
	}
}