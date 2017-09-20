package azura.avalon.maze3.ui.stationPlayer
{
	import azura.banshee.zebra.node.ZebraNode;
	import azura.common.ui.grid.GridI;
	import azura.common.ui.grid.ItemI;
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.mouserOld.MouserDragI;
	
	public class ClassifyListDisplay implements GridI,MouserDragI
	{
		public var host:LayerMaze3Station;
		public var znode:ZebraNode;
		
		public function ClassifyListDisplay(host:LayerMaze3Station)
		{
			this.host=host;
		}
		
		public function onDragStart(md:MouserDrag):void
		{
//			trace("click at",md.position.x,md.position.y,this);
			host.gridMotorList.dragStart();
		}
		
		public function onDragMove(md:MouserDrag):void
		{
			host.gridMotorList.dragMove(md.delta.x,md.delta.y);
		}
		
		public function onDragEnd(md:MouserDrag):void
		{
			host.gridMotorList.dragEnd();
		}
		
		public function gridMoveItem(item:ItemI, x:Number, y:Number):void
		{
			var icon:ZebraIcon=item as ZebraIcon;
			icon.zn.move(x,y);
			
			//			trace("move item",x,y,this);
		}
		
		public function gridMoveShell(x:Number, y:Number):void
		{			
			//			var icon:ZebraIcon=item as ZebraIcon;
			//			icon.zn.move(x,y);
			//			trace("move shell",x,y,this);
			znode.move(x,y);
		}
		
		public function showHead(value:Boolean):void
		{
		}
		
		public function showTail(value:Boolean):void
		{
		}
		
		public function gridPageSize(value:int):void
		{
		}
		
		public function gridPageCount(value:int):void
		{
		}
		
		public function gridAtPage(idx:int):void
		{
		}
	}
}