package azura.banshee.zbox2.zebra.zimage
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.banshee.zebra.branch.ZimageLarge2Tile;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	
	public class ZimageLargeTileC2 extends Zbox2Container implements Zbox2ControllerI
	{
		public var host:ZimageLargeC2;
		public var tile:ZimageLarge2Tile;
		
		public function ZimageLargeTileC2(parent:Zbox2,host:ZimageLargeC2)
		{
			super(parent);
			this.host=host;
		}
		
		public function feed(data:ZimageLarge2Tile):void{
			tile=data;
			
			var frame:Zframe2=tile.host.atlas.frameList[tile.idxInAtlas];
//			frame.smoothing=false;
			var dz:int=tile.pyramid.zMax-tile.fi.z;
			zbox.load(frame,dz);
			
			if(tile.fi.z==0)
				return;
			
			var ds:Number=FastMath.pow2x(dz);
			var shift:int=FoldIndex.sideLength(tile.pyramid.zMax)/2*512-ds*256;
			var dx:int=tile.x*ds*512-shift;
			var dy:int=tile.y*ds*512-shift;
			
//			zbox.replica.smoothing=false;
			zbox.move(dx,dy);
		}
		
		override public function get sortValue():Number{
			return tile.fi.z;
		}
		
		override public function notifyLoadingFinish():void{
			host.notifyTileLoaded(this.tile);
		}
		
		override public function notifyDispose():void{
//			trace("notify dispose",tile.fi,this);
		}
		
		
		//		override public function notifyDispose():void{
		//			trace("dispose",tile.fi,this);
		//		}
	}
}