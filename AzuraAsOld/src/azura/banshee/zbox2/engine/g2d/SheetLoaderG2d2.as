package azura.banshee.zbox2.engine.g2d
{
	
	import azura.banshee.zebra.data.wrap.Zsheet2;
	import azura.common.algorithm.FastMath;
	import azura.common.async2.AsyncLoader2;
	import azura.gallerid4.Gal4;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	
	import flash.utils.setTimeout;
	
	public class SheetLoaderG2d2 extends AsyncLoader2
	{
		protected var delay:int;
//		protected var texture:GTexture;
		protected var ga:GTextureAtlas;
		public var sheet:Zsheet2;
		
		private static var count:int=0;
		
		public function SheetLoaderG2d2(zt:Zsheet2,delay:int)
		{
			super(zt.me5ByPlatform);
			this.sheet=zt;
			this.delay=delay;
		}
		
		override public function process():void
		{
			count++;
//			trace("active sheet",count,this);
//			trace("load sheet",key,this);
			Gal4.readAsync(sheet.me5ByPlatform,fileLoaded);
			function fileLoaded(g:Gal4):void{
				g.data.uncompress();
				
				ga=GTextureAtlas.getTextureAtlasById(sheet.me5ByPlatform);
				if(ga==null)
					ga=GTextureAtlasFactory.createFromATFAndXml(sheet.me5ByPlatform,g.data,Xml.parse("<root></root>"));
				
				setTimeout(submit,FastMath.random(delay/2,delay),ga);
			}
		}
		
		override public function dispose():void{
//			sheet.=null;
			sheet=null;
//			if(texture!=null){
//				texture.dispose();
//				texture=null;
//			}
			if(ga!=null){
				ga.dispose();
				ga=null;
			}
			count--;
//			trace("active sheet",count,this);
//			trace("dispose sheet",key,this);
		}
		
	}
}