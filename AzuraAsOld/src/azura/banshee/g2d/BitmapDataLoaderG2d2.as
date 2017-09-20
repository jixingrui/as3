package azura.banshee.g2d
{
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.common.loaders.BitmapDataLoader;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	
	public class BitmapDataLoaderG2d2 extends TextureLoaderBase
	{
		
		public function BitmapDataLoaderG2d2(zt:ZsheetOp)
		{
			super(zt);
		}
		
		override public function process():void
		{
//			atlas=GTextureAtlasFactory.createFromBitmapDataAndXml(sheet.mc5,sheet.bitmapData,Xml.parse("<root></root>"));
//			submit(atlas);
			texture=GTextureFactory.createFromBitmapData(sheet.me5,sheet.bitmapData);
			submit(texture);
		}
		
	}
}