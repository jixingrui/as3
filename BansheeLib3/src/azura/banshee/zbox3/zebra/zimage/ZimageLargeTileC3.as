package azura.banshee.zbox3.zebra.zimage
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zbox3.engine.FrameCarrier;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.banshee.zebra.branch.ZimageLarge2Tile;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	
	public class ZimageLargeTileC3 extends Zbox3Container implements Zbox3ControllerI
	{
		public var host:ZimageLargeC3;
		public var tile:ZimageLarge2Tile;
		
		public function ZimageLargeTileC3(parent:Zbox3,host:ZimageLargeC3)
		{
			super(parent);
			this.host=host;
		}
		
		public function feed(data:ZimageLarge2Tile):void{
			tile=data;
			
			var frame:Zframe2=tile.host.atlas.frameList[tile.idxInAtlas];
//			frame.smoothing=false;
			var dz:int=tile.pyramid.zMax-tile.fi.z;
			
			var loader:FrameCarrier=new FrameCarrier();
			loader.frame=frame;
//			loader.loader=zbox.replica.loader;
//			loader.smoothing=false;
			zbox.load(loader);
			
			zbox.sortValue=tile.fi.z;
			
			var ds:Number=FastMath.pow2x(dz);
			
			var shift:Number=FoldIndex.sideLength(tile.pyramid.zMax)/2*512/ds-256;
			var dx:int=tile.x*512-shift;
			var dy:int=tile.y*512-shift;
			
//			var shift:int=FoldIndex.sideLength(tile.pyramid.zMax)/2*512-ds*256;
//			var dx:int=tile.x*ds*512-shift;
//			var dy:int=tile.y*ds*512-shift;
			
			zbox.scaleLocal=ds;
			
			zbox.move(dx,dy);
		}
		
		override public function notifyInitialized():void{
			host.notifyTileLoaded(this.tile);
		}
		
	}
}