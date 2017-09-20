package azura.banshee.g2d.old
{
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import azura.banshee.g2d.TextureLoaderBase;
	
	public class AtfLoaderG2d2 extends TextureLoaderBase
	{
		protected var delay:int=50;
		
		public function AtfLoaderG2d2(zt:ZsheetOp)
		{
			super(zt);
			throw new Error();
//			this.delay=delay;
		}
		
		override public function process():void
		{
			Gallerid.singleton().getData(sheet.me5).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{

				var data:ZintBuffer=item.dataClone();
				data.uncompress();

//				texture=GTextureFactory.createFromATF(sheet.mc5,data);

//				submit(texture);
//				setTimeout(submit,FastMath.random(delay/2,delay),texture);
//				setTimeout(submit,delay,texture);
			}
		}
	}
}