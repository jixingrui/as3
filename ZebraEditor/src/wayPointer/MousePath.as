package wayPointer
{
	import azura.mouse.MouseDUMI;
	
	import flash.geom.Point;
	
	public class MousePath implements MouseDUMI
	{
		private var host:LayerWayPointer;
		[Bindable]
		public var start_end:Boolean=true;
		
		public function MousePath(host:LayerWayPointer)
		{
			this.host=host;				
		}
		
		public function get priority():int{
			return 0;
		}
		
		public function mouseDown(x:int, y:int):Boolean
		{
			var xg:int=host.root.xView+x/host.root.root.scaleLocal;
			var yg:int=host.root.yView+y/host.root.root.scaleLocal;
			
			if(start_end){
				
				if(!host.wayFinder.start(xg,yg)){
					host.drawPoint(xg,yg,0xff888888,4);
					return true;
				}
				
				start_end=false;
				host.drawPoint(xg,yg,0xff00ff00,4);
				host.mouseMode=LayerWayPointer.MOUSEDRAGSCREEN;
			}else{
				
				if(!host.wayFinder.end(xg,yg)){
					host.drawPoint(xg,yg,0xff888888,4);
					return true;
				}
				
				start_end=true;
				host.drawPoint(xg,yg,0xff00ff00,4);
				
				var path:Vector.<Point>=host.wayFinder.searchPath();
				
				var next:Point;
				for each(next in path){
					host.drawPoint(next.x,next.y,0xffff0000,4);
				}
				host.mouseMode=LayerWayPointer.MOUSEDRAGSCREEN;
			}
			
			return true;
		}
		
		public function mouseMove(x:int, y:int):void
		{
		}
		
		public function mouseUp(x:int, y:int):void
		{
		}
	}
}

