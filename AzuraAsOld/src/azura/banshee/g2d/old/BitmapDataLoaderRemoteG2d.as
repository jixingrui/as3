package azura.banshee.g2d.old
{
	import azura.common.loaders.BitmapDataLoader;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	
	public class BitmapDataLoaderRemoteG2d extends LoaderG2d
	{
		private var tex:GTexture;
		
		public function BitmapDataLoaderRemoteG2d(pack:LoaderPackG2d)
		{
			super(pack);
		}
		
//		override protected function getKey(pack:LoaderPackG2d):String{
//			return pack.zd.mc5;
//		}
//		
//		override public function process():void
//		{
//			Gallerid.singleton().getData(pack.zd.mc5).onReady.add(fileLoaded);
//			function fileLoaded(item:GalItem):void{
//				
//				BitmapDataLoader.load(bdLoaded,item.dataClone());
//				function bdLoaded(bd:BitmapData):void{
//					tex=GTextureFactory.createFromBitmapData(pack.zd.mc5,bd);
//					submit(tex);
//				}
//			}
//		}
		
		override public function dispose():void
		{
			tex.dispose();
			tex=null;
		}
	}
}