package azura.banshee.loaders.g2d
{
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	
	import old.azura.avalon.ice.dish.Shard;
	import old.azura.banshee.naga.Frame;
	
	import azura.common.async2.AsyncLoader2;
	
	
	public class ShardLoaderG extends AsyncLoader2
	{
		private var shard:Shard;
		private var frame:Frame;
		private var fl:FrameLoaderG;
		
		public function ShardLoaderG(key:String,shard:Shard,frame:Frame)
		{
			super(key);
			this.shard=shard;
			this.frame=frame;
		}
				
		override public function process():void
		{
			fl=new FrameLoaderG(frame);
			fl.load(loaded);
			function loaded(fl:FrameLoaderG):void{
				fl.hold();
				
				var s:GSprite=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
				s.texture=fl.value as GTexture;
				s.node.transform.alpha=0.7;
				s.node.transform.x=shard.x+frame.xLeftTop;
				s.node.transform.y=shard.y+frame.yLeftTop;
				s.node.userData.set("depth",shard.depth);
								
				submit(s);
			}
		}
		
		override public function dispose():void
		{
			fl.release(20000);
			GSprite(value).dispose();
		}
	}
}