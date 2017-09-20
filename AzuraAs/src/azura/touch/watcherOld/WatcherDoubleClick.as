package azura.touch.watcherOld
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class WatcherDoubleClick extends EventDispatcher
	{
		private var target:EventDispatcher;
		
		private static var maxTime:int = 500;
		private static var maxDistance:Number = 200;
		
		private var timer:Timer;
		private var firstPos:Point;
		private var downCount:int;
		
		public function WatcherDoubleClick(target:EventDispatcher)
		{
			this.target=target;
			
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
				if(dist<maxDistance)
					dispatchEvent(new WatcherEvent(WatcherEvent.DOUBLECLICK));
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
			target.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			target.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			target=null;
		}
	}
}