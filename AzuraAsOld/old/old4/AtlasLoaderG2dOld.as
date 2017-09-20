package azura.banshee.loaders.g2d.old
{
	import azura.common.async2.AsyncLoader2;
	import azura.gallerid3.GalItem;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	import azura.banshee.loaders.g2d.LoaderInitializer;
	import azura.banshee.loaders.g2d.PackG2d;
	
	public class AtlasLoaderG2dOld extends AsyncLoader2
	{
		private var atlas:GTextureAtlas;
		public var pack:PackG2d;
		
		public function AtlasLoaderG2dOld(pack:PackG2d)
		{
			super(pack.piece.mc5);
			this.pack=pack;
			LoaderInitializer.singleton();
		}
		
		override public function process():void
		{
			Gallerid.singleton().getData(pack.piece.mc5,fileLoaded);
			function fileLoaded(item:GalItem):void{
				item.data.uncompress();
				
				atlas = GTextureAtlasFactory.createFromATFAndXml(pack.piece.mc5,item.data,Xml.parse("<root></root>"));
				
				submit(atlas);
			}
		}
		override public function dispose():void
		{
			atlas.dispose();
			atlas=null;
		}
	}
}