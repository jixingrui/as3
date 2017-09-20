package azura.avalon.maze.canvas.player
{
	import flash.geom.Point;
	
	public class MouseDragScreen 
	{
		private var host:LayerMazePlayer;
		private var downScreen:Point;
		private var downRoot:Point;
		
		public function MouseDragScreen(host:LayerMazePlayer)
		{
			this.host=host;
		}
		
		public function get priority():int{
			return 0;
		}
		
		public function mouseDown(x:int, y:int):Boolean
		{
			var hit:Boolean=host.root.touch(x,y);
			if(hit)
				return true;
			
			downScreen=new Point(x,y);
			downRoot=new Point(host.root.xRoot,host.root.yView);
			return true;
		}
		
		public function mouseMove(x:int, y:int):void
		{
			if(downScreen==null)
				return;
			
			var dx:Number=(downScreen.x-x)/host.root.scaleLocal;
			var dy:Number=(downScreen.y-y)/host.root.scaleLocal;			
			host.root.lookAt(downRoot.x+dx,downRoot.y+dy);
		}
		
		public function mouseUp(x:int, y:int):void
		{
			downScreen=null;
		}
	}
}