package azura.avalon.maze.data
{
	import azura.common.algorithm.pathfinding.astar2.AStarNode;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	public class RoomShellOld implements BytesI
	{
		[Bindable]
		public var data:Room2D=new Room2D();
		public var regionList:Vector.<RegionNode>=new Vector.<RegionNode>();
		public var doorList:Vector.<Door>=new Vector.<Door>();
		public var itemList:Vector.<Item>=new Vector.<Item>();
		
		public function getItem(name:String):Item{
			var item:Item;
			for(var i:int=0;i<itemList.length;i++){
				item=itemList[i];
				if(item.name==name)
					break;
			}
			return item;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			data.fromBytes(zb.readBytesZ());
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var door:Door=new Door();
				door.fromBytes(zb.readBytesZ());
				doorList.push(door);
			}
			length=zb.readZint();
			for(i=0;i<length;i++){
				var item:Item=new Item();
				item.fromBytes(zb.readBytesZ());
				itemList.push(item);
			}
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
		
		public function toString():String{
			return "[R]"+data.name;
		}
	}
}