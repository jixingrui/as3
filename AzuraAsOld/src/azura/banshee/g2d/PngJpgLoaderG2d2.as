package azura.banshee.g2d
{
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.common.async2.AsyncLoader2;
	import azura.common.loaders.BitmapDataLoader;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	
	public class PngJpgLoaderG2d2 extends TextureLoaderBase
	{
		
		public function PngJpgLoaderG2d2(zt:ZsheetOp)
		{
			super(zt);
		}
		
		override public function process():void
		{
			Gallerid.singleton().getData(sheet.me5).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				
				BitmapDataLoader.load(bdLoaded,item.dataClone());
				function bdLoaded(bd:BitmapData):void{
					atlas=GTextureAtlasFactory.createFromBitmapDataAndXml(sheet.me5,sheet.bitmapData,Xml.parse("<root></root>"));
					submit(atlas);
//					texture=GTextureFactory.createFromBitmapData(sheet.mc5,bd);
//					submit(texture);
				}
			}
		}
		
	}
}