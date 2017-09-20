package azura.banshee.zebra.zimage
{
	import azura.banshee.zebra.zode.ZframeOp;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.banshee.zebra.zode.Zshard;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	public class ZimageLargeSprite extends Zshard
	{
		private var shard:ZframeOp=new ZframeOp();
		internal var tile:ZimageLargeTile;
		private var ret:Function;
		
		public function ZimageLargeSprite(parent:ZboxOld,tile:ZimageLargeTile)
		{
			super(parent);
			this.tile=tile;
			
			shard.sheet=new ZsheetOp();			
			shard.subId=tile.fi.toString();			
			shard.sheet.textureType=tile.textureType;
//			shard.sheet.isAtlas=false;
			shard.sheet.usageType=ZsheetOp.Land;
			shard.sheet.me5=tile.mc5;
			shard.depth=tile.fi.z;
			shard.rectOnSheet=new Rectangle(0,0,256,256);
			
			var scale:int=FastMath.pow2x(tile.pyramid.zMax-tile.fi.z);
			shard.scale=scale;
			
			shard.driftX=tile.fi.xp*scale*256+scale*128-FastMath.pow2x(tile.pyramid.zMax)*128;
			shard.driftY=tile.fi.yp*scale*256+scale*128-FastMath.pow2x(tile.pyramid.zMax)*128;
		}
		
		public function load(ret:Function):void{
			this.ret=ret;
			
			shard.sheet.onLoaded.add(onLoaded);
			host.loadTexture(shard.sheet);
		}
		
		private function onLoaded():void{
			display(shard);
//			setTimeout(ret,50,this);
			ret.call(null,this);
		}
		
		override public function dispose():void{
			shard.sheet.loader.release(30000);
			super.dispose();
		}
	}
}
