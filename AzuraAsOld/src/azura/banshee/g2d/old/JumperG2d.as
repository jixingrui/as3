package azura.banshee.g2d.old
{
	
	import com.genome2d.signals.GNodeMouseSignal;
	
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	public class JumperG2d
	{
		private var last:Point;
		private var dragMoving:Boolean;
		private var pos:Point=new Point();
		
		private var zUp:int;
		
		private var _onMove:Signal=new Signal(Point);
				
		public function get onMove():Signal
		{
			return _onMove;
		}
		
		public function stop():void{
		}
		
		public function get currentPos():Point{
			return pos.clone();
		}
		
		public function onMouseDown(s:GNodeMouseSignal):void{
			trace("mouse down");
			dragMoving=true;
			last=s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
		}
		
		public function onMouseMove(s:GNodeMouseSignal):void{
			if(!dragMoving)
				return;
			
			var current:Point=s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
//			trace(current);
			var dx:int=(last.x-current.x)*(zUp+1);
			var dy:int=(last.y-current.y)*(zUp+1);
			pos.x+=dx;
			pos.y+=dy;
			last=current;
			onMove.dispatch(pos.clone());
		}
		
		public function onMouseUp(s:GNodeMouseSignal):void{
			trace("mouse up");
			dragMoving=false;
		}
		
	}
}