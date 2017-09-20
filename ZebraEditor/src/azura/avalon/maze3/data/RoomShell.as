package azura.avalon.maze3.data
{
	import azura.avalon.maze.data.RegionNode;
	import azura.avalon.maze3.data.Mdoor;
	import azura.avalon.maze3.data.Mroom;
	import azura.avalon.maze3.data.Mwoo;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.pathfinding.astar2.AStarNode;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	public class RoomShell implements BytesI
	{
		[Bindable]
		public var room:Mroom=new Mroom();
		public var doorList:Vector.<Mdoor>=new Vector.<Mdoor>();
		public var wooList:Vector.<Mwoo>=new Vector.<Mwoo>();
		
		//use
		public var regionList:Vector.<RegionNode>=new Vector.<RegionNode>();
		
		public function getMwoo(name:String):Mwoo{
			var item:Mwoo;
			for(var i:int=0;i<wooList.length;i++){
				item=wooList[i];
				if(item.name==name)
					break;
			}
			return item;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			room.fromBytes(zb.readBytesZ());
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var door:Mdoor=new Mdoor();
				door.fromBytes(zb.readBytesZ());
				doorList.push(door);
			}
			length=zb.readZint();
			for(i=0;i<length;i++){
				var item:Mwoo=new Mwoo();
				item.fromBytes(zb.readBytesZ());
				wooList.push(item);
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytesZ(room.toBytes());
			zb.writeZint(doorList.length);
			for each(var d:Mdoor in doorList){
				zb.writeBytesZ(d.toBytes());
			}
			zb.writeZint(wooList.length);
			for each(var w:Mwoo in wooList){
				zb.writeBytesZ(w.toBytes());
			}
			return zb;
		}
		
		public function toString():String{
			return "[R]"+room.name;
		}
	}
}