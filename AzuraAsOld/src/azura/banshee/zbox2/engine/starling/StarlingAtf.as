package azura.banshee.zbox2.engine.starling
{
	
	import azura.banshee.zebra.data.wrap.Zsheet2;
	import azura.common.async2.AsyncLoader2;
	import azura.gallerid4.Gal4;
	
	import starling.textures.Texture;
	
	public class StarlingAtf extends AsyncLoader2
	{
		protected var delay:int;
		public var sheet:Zsheet2;
		public var texture:Texture;
		
		private static var count:int=0;
		
		public function StarlingAtf(zt:Zsheet2,delay:int)
		{
			super(zt.me5ByPlatform);
			this.sheet=zt;
			this.delay=delay;
		}
		
		override public function process():void
		{
			count++;
			//			trace("active sheet",count,this);
			Gal4.readAsync(sheet.me5ByPlatform,fileLoaded);
			function fileLoaded(g:Gal4):void{
				g.data.uncompress();
				
				texture=Texture.fromAtfData(g.data,1,false);
				submit(texture);
			}
		}
		
		override public function dispose():void{
			sheet=null;
			if(texture!=null){
				texture.dispose();
				texture=null;
			}
			count--;
			//			trace("active sheet",count,this);
		}
		
	}
}