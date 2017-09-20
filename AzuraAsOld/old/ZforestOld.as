package azura.banshee.zebra
{
	import azura.banshee.zforest.Core1;
	import azura.common.algorithm.pathfinding.PathStrider;
	import azura.banshee.zforest.Zbase;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	import azura.banshee.zforest.Zmask;
	
	public class ZforestOld implements BytesI
	{
		public var mask:Zmask=new Zmask();
		public var base:Zbase=new Zbase();
		public var land:Zebra=new Zebra();
		
		private var core:PathStrider;
		
		public function findPath(startX:int,startY:int,endX:int,endY:int):Vector.<Point>{
			return core.find(startX,startY,endX,endY);
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var zforest:String=zb.readUTF();
			var t:int=getTimer();
			land.fromBytes(zb.readBytes_());
//			trace("land loaded",getTimer()-t,this);
			t=getTimer();
			mask.fromBytes(zb.readBytes_());
//			trace("mask loaded",getTimer()-t,this);
			t=getTimer();
			base.fromBytes(zb.readBytes_());
//			trace("base loaded",getTimer()-t,this);
			t=getTimer();
			
			core=new PathStrider();
			core.setMap(base);
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTF('zforest');
			zb.writeBytes_(land.toBytes());
			zb.writeBytes_(mask.toBytes());
			zb.writeBytes_(base.toBytes());
			return zb;
		}
		
		public function clear():void
		{
			land.clear();
			mask.clear();
			base.clear();
		}
	}
}