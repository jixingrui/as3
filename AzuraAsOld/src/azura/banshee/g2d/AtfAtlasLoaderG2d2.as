package azura.banshee.g2d
{
	
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	import azura.gallerid4.Gal4;
	
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	
	import flash.utils.setTimeout;
	
	public class AtfAtlasLoaderG2d2 extends TextureLoaderBase
	{
		protected var delay:int;
		
		public function AtfAtlasLoaderG2d2(zt:ZsheetOp,delay:int)
		{
			super(zt);
			this.delay=delay;
		}
		
		override public function process():void
		{
			//			Gallerid.singleton().getData(sheet.mc5).onReady.add(fileLoaded);
			Gal4.readAsync(sheet.me5,fileLoaded);
			function fileLoaded(g:Gal4):void{
				
				//				var data:ZintBuffer=item.dataClone();
				g.data.uncompress();
				
				atlas=GTextureAtlas.getTextureAtlasById(sheet.me5);
				if(atlas==null)
					atlas=GTextureAtlasFactory.createFromATFAndXml(sheet.me5,g.data,Xml.parse("<root></root>"));
				
				//				trace("tex loaded",key,this);
				setTimeout(submit,FastMath.random(delay/2,delay),atlas);
			}
		}
		
	}
}