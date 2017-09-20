package azura.avalon.maze.data
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.Dictionary;
	
	public class MazeOld implements BytesI
	{
		//data
		public var roomList:Vector.<RoomShellOld>=new Vector.<RoomShellOld>();
		
		//use
		private var uid_Door:Dictionary=new Dictionary();
		
		private var name_Room:Dictionary=new Dictionary();
		
		public var name_Item:Dictionary=new Dictionary();
		
		public function cleanPath():void{
			for each(var ro:RoomShellOld in roomList){
				for each(var r:RegionNode in ro.regionList){
					r.pathStart=null;
					r.pathEnd=null;
					r.isTerminal=false;
					r.doorsToShow=new Vector.<Door>();
				}
			}
		}			
		
		private function makeIndex():void{
			var re:RegionNode;
			for each(var ro:RoomShellOld in roomList){
				for(var i:int=0;i<ro.data.regions;i++){
					re=new RegionNode(ro);
					ro.regionList.push(re);
				}
				for each(var d:Door in ro.doorList){
					uid_Door[d.uid]=d;
					d.regionNode=ro.regionList[d.region];
					d.regionNode.doorList.push(d);
				}
				for each(var item:Item in ro.itemList){
					if(name_Item[item.name]!=null)
						throw new Error("Item name conflict");
					name_Item[item.name]=item;
					item.regionNode=ro.regionList[item.region];
				}
			}
			
			for each(var door:Door in uid_Door){
				door.toDoor=uid_Door[door.toDoorUid];
			}
		}
		
		private function makeMap():void{
			var d:Door;
			for each(var ro:RoomShellOld in roomList){
				name_Room[ro.data.name]=ro;
				for each(var re:RegionNode in ro.regionList){
					for each(d in re.doorList){
						re.link(d);
						d.link(re);
					}
					for(var left:int=0;left<re.doorList.length;left++)
						for(var right:int=left+1;right<re.doorList.length;right++){
							if(re.doorList[left].region==re.doorList[right].region){
								re.doorList[left].link(re.doorList[right]);
								re.doorList[right].link(re.doorList[left]);								
							}
						}
				}
			}
			
			for each(d in uid_Door){
				if(d.toDoor!=null){
					d.link(d.toDoor);
				}
			}
		}
		
		public function getDoor(uid:String):Door{
			return uid_Door[uid];
		}
		
		public function getRoom(name:String):RoomShellOld{
			return name_Room[name];
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{

			var size:int=zb.readZint();
			for(var i:int=0;i<size;i++){
				var r:RoomShellOld=new RoomShellOld();
				roomList.push(r);
				r.fromBytes(zb.readBytesZ());
			}
			
			makeIndex();
			makeMap();
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
	}
}