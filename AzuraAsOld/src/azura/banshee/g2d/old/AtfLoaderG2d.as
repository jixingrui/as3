package azura.banshee.g2d.old
{
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	public class AtfLoaderG2d extends LoaderG2d
	{
		private var tex:GTexture;
		protected var delay:int=0;
		
		public function AtfLoaderG2d(pack:LoaderPackG2d)
		{
			super(pack);
//			Gallerid.singleton().touch(pack.piece.mc5);
			delay=100;
		}
		
//		override protected function getKey(pack:LoaderPackG2d):String{
//			return pack.zd.mc5;
//		}
		
		override public function process():void
		{
//			Gallerid.singleton().getData(pack.zd.mc5).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{

				var data:ZintBuffer=item.dataClone();
				data.uncompress();

//				tex=GTextureFactory.createFromATF(pack.zd.mc5,data);

				setTimeout(submit,FastMath.random(delay/2,delay),tex);
			}
		}
		
		override public function dispose():void
		{
			tex.dispose();
			tex=null;
		}
	}
}