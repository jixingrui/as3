package azura.banshee.engine.starling_away
{
	import azura.common.async2.Async2;
	import azura.common.async2.AsyncLoader2;
	import azura.gallerid4.Gal4;
	
	import starling.textures.Texture;
	
	public class StarlingAtf2Vip extends AsyncLoader2
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
		
		override public function process():void
		{
			Gal4.readAsync(key,fileLoaded);
			function fileLoaded(g:Gal4):void{
				g.data.uncompress();
				loadAsync(g);
			}
		}
		
		private function loadAsync(g:Gal4):void{
			var texture:Texture=Texture.fromAtfData(g.data,1,false,texLoaded);
			function texLoaded(tex:Texture):void{
				submit(texture);
			}
		}
		
		override public function dispose():void{
			if(value!=null){
				Texture(value).dispose();
			}
		}
	}
}