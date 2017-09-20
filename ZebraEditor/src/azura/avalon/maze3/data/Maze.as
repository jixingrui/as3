package azura.avalon.maze3.data
{
	import azura.avalon.maze.data.RegionNode;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.Dictionary;
	
	public class Maze implements BytesI
	{
		//data
		public var roomList:Vector.<RoomShell>=new Vector.<RoomShell>();
		
		//use
		private var uid_Door:Dictionary=new Dictionary();
		
		private var uid_Room:Dictionary=new Dictionary();
		
		private var name_Room:Dictionary=new Dictionary();
		
		public var name_Item:Dictionary=new Dictionary();
		
		
		private function makeIndex():void{
//			var re:RegionNode;
			for each(var rs:RoomShell in roomList){
//				for(var i:int=0;i<rs.room.regions;i++){
//					re=new RegionNode(rs);
//					rs.regionList.push(re);
//				}
				uid_Room[rs.room.uid]=rs;
				for each(var d:Mdoor in rs.doorList){
					d.room=rs;
					uid_Door[d.uid]=d;
//					d.regionNode=rs.regionList[d.region];
//					d.regionNode.doorList.push(d);
				}
//				for each(var w:Mwoo in rs.wooList){
//					if(name_Item[w.name]!=null)
//						throw new Error("Item name conflict");
//					name_Item[w.name]=w;
//					item.regionNode=rs.regionList[item.region];
//				}
			}
			
//			for each(var door:Mdoor in uid_Door){
//				door.toDoor=uid_Door[door.toDoorUid];
//			}
		}
		
//		private function makeMap():void{
//			var d:Mdoor;
//			for each(var rs:RoomShell in roomList){
//				name_Room[rs.room.name]=rs;
//				for each(var re:RegionNode in rs.regionList){
//					for each(d in re.doorList){
//						re.link(d);
//						d.link(re);
//					}
//					for(var left:int=0;left<re.doorList.length;left++)
//						for(var right:int=left+1;right<re.doorList.length;right++){
//							if(re.doorList[left].region==re.doorList[right].region){
//								re.doorList[left].link(re.doorList[right]);
//								re.doorList[right].link(re.doorList[left]);								
//							}
//						}
//				}
//			}
			
//			for each(d in uid_Door){
//				if(d.toDoor!=null){
//					d.link(d.toDoor);
//				}
//			}
//		}
		
		public function uidToDoor(uid:String):Mdoor{
			return uid_Door[uid];
		}
		
		public function uidToRoom(uid:String):RoomShell{
			return uid_Room[uid];
		}
//		public function getRoom(name:String):RoomShell{
//			return name_Room[name];
//		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var size:int=zb.readZint();
			for(var i:int=0;i<size;i++){
				var r:RoomShell=new RoomShell();
				roomList.push(r);
				r.fromBytes(zb.readBytesZ());
			}
			
			makeIndex();
//			makeMap();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(roomList.length);
			for each(var r:RoomShell in roomList){
				zb.writeBytesZ(r.toBytes());
			}
			return zb;
		}
	}
}