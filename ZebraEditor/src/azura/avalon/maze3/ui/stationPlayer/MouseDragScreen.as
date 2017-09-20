package azura.avalon.maze3.ui.stationPlayer
{
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.mouserOld.MouserDragI;
	
	import flash.geom.Point;
	
	public class MouseDragScreen implements MouserDragI
	{		
		private var host:LayerMaze3Station;		
		private var downRoot:Point;		
		
		public function MouseDragScreen(host:LayerMaze3Station)
		{
			this.host=host;
		}
		
		public function onDragStart(md:MouserDrag):void
		{
			downRoot=new Point(host.rootHud.xRoot,host.rootHud.yView);
			
			host.rootHud.touch(md.position.x,md.position.y);
		}
		
		public function onDragMove(md:MouserDrag):void
		{			
			var dx:Number=-md.delta.x/host.rootHud.scaleLocal;
			var dy:Number=-md.delta.y/host.rootHud.scaleLocal;		
			host.rootHud.lookAt(downRoot.x+dx,downRoot.y+dy);
		}
		
		public function onDragEnd(md:MouserDrag):void
		{
		}
	}
}