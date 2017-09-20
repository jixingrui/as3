package old.azura.avalon.ice.map
{
	import azura.banshee.zebra.zimage.large.TileZimage;
	import azura.banshee.zsheet.Ztexture;
	import azura.common.async2.AsyncLoader2;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid.Gal_Http2Old;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	
	public class MapLoaderG extends AsyncLoader2
	{
		private var front:Boolean;
		private var tex:GTexture;
		
//		public var tile:TileLand;
		
		public function MapLoaderG(tile:TileZimage)
		{
			super(tile);
//			this.tile=tile;
//			this.front=front;
		}
		
		public function get tile():TileZimage{
			return key as TileZimage;
		}
				
		override public function process():void
		{
//			var mc5:String=tile.mc5;
//			Gal_Http.load(mc5,fileLoaded,front);=================================
			new Gal_Http2Old(tile.mc5).load(fileLoaded);
			function fileLoaded(gh:Gal_Http2Old):void{
//				gh.hold();
				var zb:ZintBuffer=ZintBuffer(gh.value);
				zb.uncompress();
//				tex=GUtils.createTextureFromATF(tile.getKey(),zb,tileLoaded);
//				tex=GTextureFactory.createFromATF(tile.getKey(),zb);
//			}
//			function tileLoaded():void{
				
				var sp:GSprite=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
//				sp.setTexture(tex);
				sp.texture=tex;
				if(tile.textureType==Ztexture.Solid)
					sp.blendMode=GBlendMode.NONE;
				
				submit(sp);
//				setTimeout(submit,0,sp);
			}
		}
		
		override public function dispose():void
		{
			GSprite(value).dispose();
			tex.dispose();
//			trace(getQualifiedClassName(this)+" dispose: "+TileLand(key).fi);
		}
		
	}
}