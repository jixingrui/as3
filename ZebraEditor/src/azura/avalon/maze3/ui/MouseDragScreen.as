package azura.avalon.maze3.ui
{
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.mouserOld.MouserDragI;
	
	import flash.geom.Point;
	
	public class MouseDragScreen implements MouserDragI
	{		
		private var host:LayerMaze3DoorEdit;		
		private var downRoot:Point;		
		
		public function MouseDragScreen(host:LayerMaze3DoorEdit)
		{
			this.host=host;
		}
		
		public function onDragStart(md:MouserDrag):void
		{
			downRoot=new Point(host.root.xView,host.root.yView);
		}
		
		public function onDragMove(md:MouserDrag):void
		{			
			var dx:Number=-md.delta.x/host.root.root.scaleLocal;
			var dy:Number=-md.delta.y/host.root.root.scaleLocal;		
			host.root.lookAt(downRoot.x+dx,downRoot.y+dy);
		}
		
		public function onDragEnd(md:MouserDrag):void
		{
		}
	}
}