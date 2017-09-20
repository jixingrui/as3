package azura.avalon.zbase.bus
{
	import azura.avalon.zbase.zway.BusMap;
	import azura.avalon.zbase.zway.CanSeeI;
	import azura.avalon.zbase.zway.WayDot45;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	
	public class RoadMap implements BytesI
	{
		public var base:ZbaseR=new ZbaseR();
		public var bus:BusMap=new BusMap();
		
		public function getStation(x:int,y:int):WayDot45{
			var xy:int=base.getStation(x,y);
			var wd:WayDot45=bus.xyToStation(xy);
			return wd;
		}
				
		public function fromBytes(zb:ZintBuffer):void
		{
			base.fromBytes(zb.readBytesZ());
			bus.fromBytes(zb.readBytesZ());
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytesZ(base.toBytes());
			zb.writeBytesZ(bus.toBytes());
			return zb;
		}
	}
}