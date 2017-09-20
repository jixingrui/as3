package azura.banshee.engine.starling_away
{
	
	import azura.banshee.engine.Statics;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.crypto.MC5;
	import azura.common.algorithm.mover.FPS;
	import azura.common.async2.Async2;
	import azura.common.async2.AsyncLoader2;
	import azura.gallerid4.Gal4;
	
	import flash.display3D.Context3D;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import starling.textures.Texture;
	
	public class StarlingAtf2 extends AsyncLoader2
	{
		private static var count:int=0;
		public static var syncMode:Boolean=true;
		
		public function StarlingAtf2(mc5:String)
		{
			super(mc5);
		}
		
		override public function process():void
		{
//			var start:int=getTimer();
			Gal4.readAsync(key,fileLoaded);
			function fileLoaded(g:Gal4):void{
//				trace("file read used",getTimer()-start,"ms");
				//uncompress is fast
				g.data.uncompress();
				
				if(syncMode){
					loadSync(g);		
				}else{
					loadDelay(g);
				}
			}
		}
		
		protected function loadDelay(g:Gal4):void{
			var delay:int=FastMath.random(lastSize/1000,g.data.length/1000*2);
			//			var delay:int=lastSize/1000*2;
			//			trace("last size=",lastSize/1000,"kb, delay=",delay,"fps=",FPS.getFps(),"StarlingAtf2");
			setTimeout(loadAsync,delay,g);
		}
		
		private static var lastSize:int=0;
		protected function loadAsync(g:Gal4):void{
//			lastSize=g.data.length;
//			var start:int=getTimer();
			var texture:Texture=Texture.fromAtfData(g.data,1,false,texLoaded);
			function texLoaded(tex:Texture):void{
//				trace("atf loading used",getTimer()-start,"ms");
				submit(texture);
			}
		}
		
		protected function loadSync(g:Gal4):void{
			var texture:Texture=Texture.fromAtfData(g.data,1,false);
			submit(texture);
		}
		
		override public function dispose():void{
			if(value!=null){
				Texture(value).dispose();
			}
		}
		
	}
}