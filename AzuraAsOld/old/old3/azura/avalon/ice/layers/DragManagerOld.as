package old.azura.avalon.ice.layers
{
	import azura.common.algorithm.FastMath;
	import azura.common.util.Fork;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mx.core.DragSource;
	
	import org.osflash.signals.Signal;

	public class DragManagerOld
	{
		private var _onClose:Signal=new Signal();
		private var _onDragMove:Signal=new Signal(int,int);
		
//		private var p1:Point=new Point();
//		private var p2:Point=new Point();
//		private var p3:Point=new Point();
//		private var p4:Point=new Point();
		
		private var p_current:Point=new Point();
		private var p_startOfTheRound:Point=new Point();
		
		private var dragging:Boolean;
		
		private var traceDist:int;
		
		private var firstClick:Boolean;

		private var w:int,h:int;
		
		public function limit(w:int,h:int):void{
			this.w=w;
			this.h=h;
		}
		
		private function limit_(x:int,y:int):Point{
			var result:Point=new Point();
			result.x=Math.min(w,Math.abs(x));
			result.y=Math.min(h,Math.abs(y));
			result.x*=FastMath.sign(x);
			result.y*=FastMath.sign(y);
			return result;
		}
		
		public function clear():void{
//			p1=new Point();
//			p2=new Point();
//			p4=new Point();
//			trace("clear");
			p_current=new Point();
			p_startOfTheRound=new Point();
			dragging=false;
			traceDist=0;
			firstClick=false;
		}
		
		public function get onDragMove():Signal
		{
			return _onDragMove;
		}

		public function get onClose():Signal
		{
			return _onClose;
		}
		
		public function start(x:int,y:int):void{
//			trace("start "+x+","+y);
			
//			p2=new Point(x,y);
//			p4=new Point(x,y);
			
			if(dragging)
				return;
			
			dragging=true;
			traceDist=0;
			
			p_startOfTheRound.x=x;
			p_startOfTheRound.y=y;
			
			setTimeout(reset,500);
			function reset():void{
				firstClick=false;
			}
		}
		
		public function move(x:int,y:int):void{
			if(dragging){
//				trace("move "+x+","+y);
				
				traceDist+=FastMath.dist(x,y,p_startOfTheRound.x,p_startOfTheRound.y);
//
//				p4.x=x;
//				p4.y=y;
				
				var xOut:int=p_current.x+x-p_startOfTheRound.x;
				var yOut:int=p_current.y+y-p_startOfTheRound.y;
				
				var p:Point=limit_(xOut,yOut);
				
				onDragMove.dispatch(p.x,p.y);
			}else{
//				clear();
			}
		}
		
		public function end(x:int,y:int):void{
//			trace("end "+x+","+y);
			
			if(!dragging)
				return;

			dragging=false;
			
			p_current.x=p_current.x+x-p_startOfTheRound.x;
			p_current.y=p_current.y+y-p_startOfTheRound.y;
			
			p_current=limit_(p_current.x,p_current.y);
			
//			p1.x-=x-p2.x;
//			p1.y-=y-p2.y;
			
//			trace(traceDist);
			
			if(traceDist<60){
				if(firstClick){
					onClose.dispatch();
				}else{
					firstClick=true;
				}
			}
		}
	}
}