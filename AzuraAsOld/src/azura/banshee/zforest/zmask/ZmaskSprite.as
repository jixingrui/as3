package azura.banshee.zforest.zmask
{
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.ZframeOp;
	import azura.banshee.zebra.zode.Zshard;
	import azura.banshee.zebra.zode.ZsheetOp;
	
	public class ZmaskSprite extends Zshard
	{
		public var shard:ZframeOp;
		
		public function ZmaskSprite(parent:ZboxOld)
		{
			super(parent);

//			shard=new ZframeOp();
//			shard.sheet=new ZsheetOp();
		}
		
		public function load():void{
			shard.sheet.onLoaded.add(onTexLoaded);
			host.loadTexture(shard.sheet);
		}
		
		private function onTexLoaded():void{
			display(shard);
		}
		
		override public function dispose():void{
			shard.sheet.loader.release(3000);
			super.dispose();
		}
	}
}