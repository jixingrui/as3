package azura.avalon.maze.canvas.old
{
	import azura.banshee.door.GroundItem;
	import azura.banshee.zebra.i.SwampI;

	public interface SwampEditI extends SwampI
	{
		function editItem(item:GroundItem):void;
		function putHere(item:GroundItem):void;
		function stopEditing():void;
	}
}