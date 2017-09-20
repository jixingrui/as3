package azura.banshee.chessboard.loaders.filter
{
	import azura.banshee.chessboard.dish.Shard;
	import azura.banshee.naga.ImageStarling;
	
	import common.async.AsyncBoxI;
	import common.async.AsyncQue;
	import common.async.AsyncTask;
	import common.async.AsyncUserA;
	
	import flash.utils.setTimeout;
	
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	
	
	public class ShardFilterLoader extends AsyncUserA
	{
		{
			AsyncQue.configSerial("shardFilter",1000,0,3);
		}
		public static function load(key:String,shard:Shard,subTexture:Texture,ret_Image_key:Function):ShardFilterLoader{
			var loader:ShardFilterLoader=new ShardFilterLoader(key,shard,subTexture,ret_Image_key);
			AsyncQue.enque("shardFilter",loader);
			return loader;
		}
		
		public var shard:Shard;
		public var subTexture:Texture;
		public var ret_Image_key:Function;
		
		public var image:ImageStarling;
		
		public function ShardFilterLoader(key:String,shard:Shard,subTexture:Texture,ret_Image_key:Function)
		{
			super(key);
			this.shard=shard;
			this.subTexture=subTexture;
			this.ret_Image_key=ret_Image_key;			
		}
		
		override public function process(answer:AsyncTask):void
		{
			var box:ShardFilterBox=new ShardFilterBox();
			//image
			box.image=new ImageStarling(subTexture);
//			box.image.smoothing='none';
			box.image.foot.x=shard.x;
			box.image.foot.y=shard.y;
			box.image.foot.depth=shard.depth;
			
			//mask
			box.mask=Texture.fromBitmapData(shard.mask);	
			
			setTimeout(filter,0);
			
			function filter():void{
				box.image.filter=new MaskFilter(box.mask);
				box.image.filter.cache();
				
				answer.submit(box);
			}
		}
		
		override public function ready(value:AsyncBoxI):void
		{
			var cache:ShardFilterBox=value as ShardFilterBox;
			image=cache.image;
			ret_Image_key.call(null,image,key);
//			b.host.addChild(b.image);
		}
	}
}