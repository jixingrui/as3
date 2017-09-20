package azura.banshee.loaders.g2d.old
{
	
	import azura.common.async2.AsyncLoader2;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.GalItem;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	
	public class AtfAtlasLoaderGOld extends AsyncLoader2
	{
		public function AtfAtlasLoaderGOld(mc5:String)
		{
			super(mc5);
		}
		
		private var gta:GTextureAtlas;
		
		private function get mc5():String{
			return key as String;
		}
		
		override public function process():void
		{
			Gallerid.singleton().getData(mc5,fileLoaded);
			function fileLoaded(item:GalItem):void{
				item.data.uncompress();
				
				gta=GTextureAtlasFactory.createFromATFAndXml(mc5,item.data,Xml.parse("<root></root>"));
				submit(gta);
			}
		}
		
		override public function dispose():void
		{
			GTextureAtlas(value).dispose();
		}
	}
}