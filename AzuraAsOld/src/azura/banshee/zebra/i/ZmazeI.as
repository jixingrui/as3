package azura.banshee.zebra.i
{
	import azura.banshee.door.Door;
	import azura.banshee.door.RoomWithDoors;
	import azura.banshee.engine.Stage3DLayerI;
	
	import org.osflash.signals.Signal;

	public interface ZmazeI extends Stage3DLayerI
	{
		function get onDoorClick():Signal;
		function set mc5Scene(value:String):void;
//		function start(x:int,y:int):void;
		function lookAt(x:int,y:int):void;
		function get x():int;
		function get y():int;
//		function showDoor(door:Door):void;
		function boot(rd:RoomWithDoors,x:int,y:int):void;
	}
}