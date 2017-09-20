package azura.avalon.ice.loaders
{
	import azura.common.async2.AsyncLoader2;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.GalItem;
	import azura.gallerid3.Gallerid;
	
	import flash.utils.setTimeout;
	
	import old.azura.avalon.ice.dish.Shard;
	import old.azura.avalon.ice.dish.TileDish;
	import old.azura.banshee.naga.Atlas;
	
	
	public class CookieLoader extends AsyncLoader2 
	{
		//		public static function load(tile:TileDish,ret:Function):CookieLoader{
		//			var loader:CookieLoader=new CookieLoader(tile,ret);
		//			Async.enque(loader);
		//			return loader;
		//		}
		//		private var tile:TileDish;
		public function CookieLoader(tile:TileDish)
		{
			super(tile);
			//			this.tile=tile;
		}
		
		private function get tile():TileDish{
			return key as TileDish;
		}
		
		public function get shardList():Vector.<Shard>{
			return CookieBox(value).shardList;
		}
		
		public function get atlas():Atlas{
			return CookieBox(value).atlas;
		}
		
		override public function process():void
		{
			//			Gal_Http.load(TileDish(key).md5Cookie,fileLoaded,true);
			//			new Gal_Http2Old(tile.md5Cookie).load(fileLoaded);
			//			function fileLoaded(gh:Gal_Http2Old):void{			
			////				gh.hold();
			//				var zb:ZintBuffer=ZintBuffer(gh.value);
			//				zb.uncompress();
			
			Gallerid.singleton().getData(tile.mc5Cookie,fileLoaded);
			function fileLoaded(item:GalItem):void{
				item.data.uncompress();
				
				var shardList:Vector.<Shard>=new Vector.<Shard>();
				var frameCount:int=item.data.readZint();
				for(var i:int=0;i<frameCount;i++){
					var shard:Shard=new Shard();
					shard.decode(item.data.readBytes_());
					shardList.push(shard);
				}
				var atlas:Atlas=new Atlas(item.data.readBytes_());
				var cb:CookieBox=new CookieBox(shardList,atlas);
				//				submit(cb);
				setTimeout(submit,0,cb);
			}
		}
		
		override public function dispose():void
		{
			//			atlas.dispose();
			//			trace("CookieLoader dispose: "+TileDish(key).fi);
		}
	}
}
