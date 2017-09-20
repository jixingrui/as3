package azura.banshee.g2d.old
{
	
	import com.genome2d.signals.GNodeMouseSignal;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	import azura.common.algorithm.mover.Easer;
	
	public class DragMoverG2d
	{
		private var pin:Point;
		private var dragMoving:Boolean;
		private var pos:Point=new Point();
		private var easer:Easer=new Easer();
		
		private var zUp:int;
		private var bound:Rectangle;
		
		private var _onMove:Signal=new Signal(Point);
		
		public function setBound(value:Rectangle,zUp:int,stageWidth:int,stageHeight:int):void{
			this.bound=value.clone();
			this.zUp=zUp;
			easer.factor=zUp;
			
			bound.x+=(stageWidth/2)<<zUp;
			bound.width-=(stageWidth)<<zUp;
			bound.y+=(stageHeight/2)<<zUp;
			bound.height-=(stageHeight)<<zUp;
			
			if(bound.width<=0||bound.height<=0){
				easer.reset(pos.x,pos.y,0,0);
			}
		}
		
		public function get onMove():Signal
		{
			return _onMove;
		}
		
		public function stop():void{
			easer.stop();
		}
		
		public function get currentPos():Point{
			return pos.clone();
		}
		
		public function onMouseDown(s:GNodeMouseSignal):void{
			dragMoving=true;
			pin=s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
		}
		
		public function onMouseMove(s:GNodeMouseSignal):void{
			if(!dragMoving)
				return;
			
			var g:Point=s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			var dx:int=(pin.x-g.x)*(zUp+1);
			var dy:int=(pin.y-g.y)*(zUp+1);
			easeTo(pos.x,pos.y,pos.x+dx,pos.y+dy);
		}
		
		private function easeTo(xStart:int,yStart:int,xEnd:int,yEnd:int):void{
			if(bound!=null){
				if(bound.width<=0)
					xEnd=0;
				else{
					xEnd=Math.max(xEnd,bound.left);
					xEnd=Math.min(xEnd,bound.right);
				}
				if(bound.height<=0)
					yEnd=0;
				else{
					yEnd=Math.max(yEnd,bound.top);
					yEnd=Math.min(yEnd,bound.bottom);
				}
			}
			easer.reset(xStart,yStart,xEnd,yEnd);
		}
		
		public function jump(x:int,y:int):void{
			easeTo(x,y,x,y);
		}
		
		public function onMouseUp(s:GNodeMouseSignal):void{
			dragMoving=false;
		}
		
		public function tick():void{
			var next:Point=easer.next();
			if(next!=null){
				pos=next;
				onMove.dispatch(pos.clone());
			}
		}
	}
}