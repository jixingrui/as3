package azura.avalon.maze3.ui.seeker
{
	import azura.avalon.maze3.data.Mdoor;
	import azura.banshee.zebra.box.AbBoxI;
	
	public class DoorObserver implements AbBoxI
	{
		public var door:Mdoor;
		public var canvas:LayerMaze3Seeker;
		public function DoorObserver(door:Mdoor,canvas:LayerMaze3Seeker)
		{
			this.door=door;
			this.canvas=canvas;
		}
		
		public function get priority():int
		{
			return 0;
		}
		
		public function zboxTouched():Boolean
		{
			trace("click door",door.name,this);
			canvas.toDoor(door.toDoorUid);
			return true;
		}
	}
}