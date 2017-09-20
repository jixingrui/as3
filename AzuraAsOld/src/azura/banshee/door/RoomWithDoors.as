package azura.banshee.door
{
	import azura.common.algorithm.FastMath;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.system.Capabilities;
	
	public class RoomWithDoors implements BytesI
	{
		public var room:Room=new Room();
		public var doorList:Vector.<Door>=new Vector.<Door>();
		
		public function fromBytes(zb:ZintBuffer):void
		{
			room.fromBytes(zb.readBytesZ());
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var door:Door=new Door();
				door.fromBytes(zb.readBytesZ());
				doorList.push(door);
			}
		}
		
		public function getDoor(uid:String):Door{
			for each(var dd:Door in doorList){
				if(dd.uid==uid)
					return dd;
			}
			return null;
		}
		
		public function searchDoor(x:int,y:int):Door{
			var dist:int=48;
			if(Capabilities.screenDPI>400)
				dist=128;
			else if(Capabilities.screenDPI>200)
				dist=80;
			for each(var d:Door in doorList){
				if(FastMath.dist(x,y,d.x,d.y)<dist){
					return d;
				}
			}
			return null;
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
		
		public function clear():void
		{
		}
	}
}