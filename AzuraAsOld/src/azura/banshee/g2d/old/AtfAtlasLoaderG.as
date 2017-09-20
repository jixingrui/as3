package azura.banshee.g2d.old
{
	
	import azura.common.algorithm.FastMath;
	import azura.common.async2.AsyncLoader2;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	public class AtfAtlasLoaderG extends LoaderG2d
	{
		public function AtfAtlasLoaderG(pack:LoaderPackG2d,delay:int=0)
		{
			super(pack);
//			Gallerid.singleton().touch(pack.piece.mc5);
			this_=this;
			this.delay=delay;
		}
		
		private var gta:GTextureAtlas;
		private var this_:AtfAtlasLoaderG;
		protected var delay:int=0;
		
		private function get mc5():String{
			return key as String;
		}
		
//		override protected function getKey(pack:LoaderPackG2d):String{
//			return pack.zd.mc5;
//		}
		
		override public function process():void
		{
			//			trace("loading",mc5,this);
			Gallerid.singleton().getData(mc5).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				
//				var t:Number=getTimer();
//				item.data.uncompress();
				var data:ZintBuffer=item.dataClone();
				data.uncompress();
//				trace('AtfAtlas uncompressed',getTimer()-t);
				//				trace("loaded",mc5,this_);	
//				t=getTimer();
				gta=GTextureAtlasFactory.createFromATFAndXml(mc5,data,Xml.parse("<root></root>"));
//				trace('AtfAtlas loaded',getTimer()-t);
				//				submit(gta);
				setTimeout(submit,FastMath.random(delay/2,delay),gta);
			}
		}
		
		override public function dispose():void
		{
			//			trace("dispose",pack.piece.mc5,this);
			gta.dispose();
			//			GTextureAtlas(value).dispose();
		}
	}
}