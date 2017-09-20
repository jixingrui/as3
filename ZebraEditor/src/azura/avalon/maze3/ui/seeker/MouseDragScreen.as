package azura.avalon.maze3.ui.seeker
{
	import azura.avalon.maze3.ui.seeker.LayerMaze3Seeker;
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.mouserOld.MouserDragI;
	
	import flash.geom.Point;
	
	public class MouseDragScreen implements MouserDragI
	{		
		private var host:LayerMaze3Seeker;		
		private var downRoot:Point;		
		
		public function MouseDragScreen(host:LayerMaze3Seeker)
		{
			this.host=host;
		}
		
		public function onDragStart(md:MouserDrag):void
		{
			downRoot=new Point(host.root.xView,host.root.yView);
			
//			host.root.touch(md.position.x,md.position.y);
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