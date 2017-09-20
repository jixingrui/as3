package azura.banshee.chessboard.loaders
{
	import azura.banshee.chessboard.dish.Shard;
	import azura.banshee.chessboard.dish.TileDish;
	import azura.banshee.naga.ImageStarling;
	import azura.banshee.naga.starling.AtlasStarling;
	import azura.gallerid.Gal_Http;
	
	import common.async.AsyncBoxI;
	import common.async.AsyncQue;
	import common.async.AsyncTask;
	import common.async.AsyncUserA;
	import common.collections.ZintBuffer;
	
	import flash.utils.setTimeout;
	
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	
	public class CookieLoader extends AsyncUserA
	{
		{
			AsyncQue.configParallel("cookie",30000,0,16);
		}
		public static function load(tile:TileDish,ret_TileDish:Function):CookieLoader{
			var loader:CookieLoader=new CookieLoader(tile,ret_TileDish);
			AsyncQue.enque("cookie",loader);
			return loader;
		}
		
		private var ret_TileDish:Function;
		
		public var shardList:Vector.<Shard>;
		private var atlas:AtlasStarling;
		
		public function CookieLoader(tile:TileDish,ret_TileDish:Function)
		{
			super(tile);
			this.ret_TileDish=ret_TileDish;
		}
		
		private function get tile():TileDish{
			return key as TileDish;
		}
		
		override public function process(answer:AsyncTask):void
		{
			Gal_Http.load(tile.md5Cookie,fileLoaded,true);
			function fileLoaded(gh:Gal_Http):void{				
				var zb:ZintBuffer=new ZintBuffer(gh.value);
				zb.uncompress();
				shardList=new Vector.<Shard>();
				var frameCount:int=zb.readZint();
				for(var i:int=0;i<frameCount;i++){
					var shard:Shard=new Shard();
					shard.decode(zb.readBytes_());
					shardList.push(shard);
				}
				atlas=new AtlasStarling(zb.readBytes_());
				answer.submit(new CookieBox(tile,shardList,atlas));
			}
		}
		
		override public function ready(value:AsyncBoxI):void
		{
			ret_TileDish.call(null,tile,shardList,atlas);
		}
	}
}
