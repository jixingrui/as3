package wayPointer
{
	import azura.mouse.MouseDUMI;
	
	import flash.geom.Point;
	
	public class MouseDragScreen implements MouseDUMI
	{
		private var host:LayerWayPointer;
		private var downScreen:Point;
		private var downRoot:Point;
		
		public function MouseDragScreen(host:LayerWayPointer)
		{
			this.host=host;
		}
		
		public function get priority():int{
			return 0;
		}
		
		public function mouseDown(x:int, y:int):Boolean
		{
//			trace("mouse down",x,y,this);
			downScreen=new Point(x,y);
			downRoot=new Point(host.root.xView,host.root.yView);
			return true;
		}
		
		public function mouseMove(x:int, y:int):void
		{
			if(downScreen==null)
				return;
			
			var dx:Number=(downScreen.x-x)/host.root.root.scaleLocal;
			var dy:Number=(downScreen.y-y)/host.root.root.scaleLocal;			
			host.root.lookAt(downRoot.x+dx,downRoot.y+dy);
		}
		
		public function mouseUp(x:int, y:int):void
		{
			downScreen=null;
		}
	}
}