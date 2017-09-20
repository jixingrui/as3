package azura.banshee.chessboard.loaders
{
	import azura.banshee.chessboard.dish.Shard;
	import azura.banshee.naga.ImageStarling;
	import azura.banshee.naga.starling.FrameStarling;
	
	import common.async.AsyncBoxI;
	import common.async.AsyncQue;
	import common.async.AsyncTask;
	import common.async.AsyncUserA;
	
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	
	public class ShardLoader extends AsyncUserA
	{
		{
			AsyncQue.configParallel("shard",30000,0,2);
		}
		public static function load(key:String,shard:Shard,frame:FrameStarling,ret_ImageWithFoot:Function):ShardLoader{
			var loader:ShardLoader=new ShardLoader(key,shard,frame,ret_ImageWithFoot);
			AsyncQue.enque("shard",loader);
			return loader;
		}
		
		public var shard:Shard;
		public var frame:FrameStarling;
		public var ret_ImageWithFoot:Function;
		
		public var image:ImageStarling;
		
		public function ShardLoader(key:String,shard:Shard,frame:FrameStarling,ret_ImageWithFoot:Function)
		{
			super(key);
			this.shard=shard;
			this.ret_ImageWithFoot=ret_ImageWithFoot;
			this.frame=frame;
			ShardBox.add(1);
		}
		
		override public function process(answer:AsyncTask):void
		{
			frame.loadTexture(loaded,false);
			function loaded(tex:Texture,idx:int):void{
				if(isDiscarded)
					return;
				
				var image:ImageStarling=new ImageStarling(tex);
//				image.smoothing=TextureSmoothing.TRILINEAR;
				image.alpha=0.7;
				image.foot.x=shard.x+frame.xLeftTop;
				image.foot.y=shard.y+frame.yLeftTop;
				image.foot.depth=shard.depth;
				image.updatePos();
				image.touchable=false;
				
				var box:ShardBox=new ShardBox();
				box.image=image;
				
				answer.submit(box);
//				trace("shard load");
			}
		}
		
		override public function ready(value:AsyncBoxI):void
		{
			var cache:ShardBox=value as ShardBox;
			image=cache.image;
			ret_ImageWithFoot.call(null,cache.image);
		}
		
		override public function discard():Boolean{
			ShardBox.add(-1);
			return super.discard();
		}
	}
}