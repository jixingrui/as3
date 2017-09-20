package azura.avalon.maze3.ui
{
	import azura.avalon.zbase.zway.WayDot45;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.common.algorithm.FastMath;
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.mouserOld.MouserDragI;
	
	import flash.geom.Point;
	
	public class MouseDragDoor implements MouserDragI
	{		
		private var host:LayerMaze3DoorEdit;	
		private var lastScreen:Point;
		private var downDoor:Point;	
		
		public function MouseDragDoor(host:LayerMaze3DoorEdit)
		{
			this.host=host;
		}
		
		public function onDragStart(md:MouserDrag):void
		{
			var x:Number=md.position.x;
			var y:Number=md.position.y;
			
			lastScreen=new Point(x,y);
			downDoor=new Point(host.root.xView+x,host.root.yView+y);
		}
		
		public function onDragMove(md:MouserDrag):void
		{			
			var dx:Number=-md.delta.x/host.root.root.scaleLocal;
			var dy:Number=-md.delta.y/host.root.root.scaleLocal;		
			
			var x:Number=md.position.x;
			var y:Number=md.position.y;
			
			host.selectedDoorNode.move(downDoor.x-dx,downDoor.y-dy);
			host.selectedDoorNode.angle=FastMath.xy2Angle(x-lastScreen.x,y-lastScreen.y);
			
			lastScreen.x=(lastScreen.x*49+x)/50;
			lastScreen.y=(lastScreen.y*49+y)/50;
		}
		
		public function onDragEnd(md:MouserDrag):void
		{
			var dest:Point=new Point();
			dest.x=host.root.xView+md.position.x;
			dest.y=host.root.yView+md.position.y;
			var wn:WayDot45=host.wayFinder.pointToNode(dest.x,dest.y);
			var group:int=-1;
			if(wn!=null){
				group=wn.group;
				
				host.door.inRegion=group;
				
				host.door.zebra.x=dest.x;
				host.door.zebra.y=dest.y;
//				host.door.dx=host.x-host.door.dx;
//				host.door.dy=host.y-host.door.dy;
				host.door.zebra.angle=host.selectedDoorNode.angle;			
				host.selectedDoorNode.move(dest.x,dest.y);
				host.panel.drDoor.save();
			}else{
				trace('not way',this);
			}
			trace("the door is in region",group,this);
			
			host.mouseMode=LayerMaze3DoorEdit.MOUSEDRAGSCREEN;
		}
	}
}