package azura.touch.mouserOld
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class MouserDoubleClick 
	{
		private var source:EventDispatcher;
		
		private static var maxTime:int = 500;
		private static var maxDistance:Number = 200;
		
		private var timer:Timer;
		private var firstPos:Point;
		private var downCount:int;
		
		public var listener:MouserDoubleClickI;
		
		public function MouserDoubleClick(target:EventDispatcher)
		{
			this.source=target;
			
			target.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			target.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
		}
		
		private function onTimeout(event:TimerEvent):void{
			clear();
		}
		
		private function mouseDown(event:MouseEvent):void{
			downCount++;
			if(timer==null){
				timer=new Timer(maxTime,1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeout);
				timer.start();
				
				firstPos=new Point(event.stageX,event.stageY);
			}
		}
		
		private function mouseUp(event:MouseEvent):void{
			if(firstPos!=null&&downCount>1){
				var dist:int=Point.distance(firstPos,new Point(event.stageX,event.stageY));
				clear();
				if(dist<maxDistance){
					listener.onDoubleClick();
				}
			}
		}
		
		public function clear():void{
			if(timer!=null)
				timer.stop();
			timer=null;
			firstPos=null;
			downCount=0;
		}
		
		public function dispose():void{
			clear();
			source.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			source.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			source=null;
			listener=null;
		}
	}
}