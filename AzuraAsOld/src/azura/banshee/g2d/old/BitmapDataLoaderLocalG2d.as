package azura.banshee.g2d.old
{
	import azura.common.loaders.BitmapDataLoader;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	
	public class BitmapDataLoaderLocalG2d extends LoaderG2d
	{
		private var tex:GTexture;
		
		public function BitmapDataLoaderLocalG2d(pack:LoaderPackG2d)
		{
			super(pack);
		}
		
//		override protected function getKey(pack:LoaderPackG2d):String{
//			return pack.zd.mc5;
//		}
//		
//		override public function process():void
//		{
//			tex=GTextureFactory.createFromBitmapData(pack.zd.mc5,pack.zd.bd);
//			submit(tex);
//		}
		
		override public function dispose():void
		{
			tex.dispose();
			tex=null;
		}
	}
}