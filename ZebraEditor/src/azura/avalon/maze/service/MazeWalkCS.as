package azura.avalon.maze.service
{
	import azura.banshee.door.Door;
	import azura.banshee.door.RoomWithDoors;
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.phoenix12.drop.maze2.service.WalkCSA;
	import azura.phoenix12.drop.maze2.service.WalkCSI;
	
	import org.osflash.signals.Signal;
	
	public class MazeWalkCS extends WalkCSA implements WalkCSI
	{
		public var onTeleport:Signal=new Signal(RoomWithDoors,int,int);
		public var uidDoor:String;
		
		public function MazeWalkCS(tunnel:RpcTunnelI)
		{
			super(SwitchNet.nsMaze2, tunnel, this);
		}
		
		public function enter(uid:String):void{
//			this.uidDoor=uid;
//			if(uid.length==0)
//				return;
//			
//			SjgSignalCenter.gameDoorJump.dispatch();
//			
//			var arg699:Datum=ns.newDatum(Arg699Hint.CLASS);
//			arg699.getBean(Arg699Hint.uid_door).setString(uid);
//			super.enterCall(arg699);
		}
		
		public function teleportHandler(arg706:Datum):void
		{
//			var data:ZintBuffer=arg706.getBean(Arg706Hint.roomFat).asBytes();
//			var rwd:RoomWithDoors=new RoomWithDoors();
//			rwd.fromBytes(data);
//			
//			var x:int=arg706.getBean(Arg706Hint.x).asInt();
//			var y:int=arg706.getBean(Arg706Hint.y).asInt();
//			var uidDoor:String=arg706.getBean(Arg706Hint.uidDoor).asString();
//			
//			var door:Door=rwd.getDoor(uidDoor);
//			
//			onTeleport.dispatch(rwd,x+door.dx,y+door.dy);
//			
//			StaticHolder.room=rwd;
		}
		
		public function connected():void
		{
		}
		
		public function disconnected():void
		{
		}
	}
}