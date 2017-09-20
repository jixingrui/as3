package azura.touch.watcherOld
{
	import azura.common.algorithm.FastMath;
	import azura.touch.watcherOld.WatcherEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	
	public class WatcherZoom extends EventDispatcher
	{
		private var target:EventDispatcher;
		
		private var touch1:Touch=new Touch();
		private var touch2:Touch=new Touch();
		
		private var oldDistX:Number;
		private var oldDistY:Number;
		
		public function WatcherZoom(target:EventDispatcher)
		{
			this.target=target;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			//			target.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin); 
			target.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
			target.addEventListener(TouchEvent.TOUCH_END, onTouchEnd); 
		}
		
		private function reset():void{
			touch1.clear();
			touch2.clear();
			oldDistX=NaN;
			oldDistY=NaN;
		}
		
		private function onTouchBegin(event:TouchEvent):void{ 
		} 
		
		private function onTouchMove(event:TouchEvent):void{
			if(touch1.id==0){
				touch1.id=event.touchPointID;
				touch1.position.x=event.stageX;
				touch1.position.y=event.stageY;
			}else if(touch1.id==event.touchPointID){
				touch1.position.x=event.stageX;
				touch1.position.y=event.stageY;
				checkZoom();
			}else if(touch2.id==0){
				touch2.id=event.touchPointID;
				touch2.position.x=event.stageX;
				touch2.position.y=event.stageY;
				
				oldDistX=Math.abs(touch1.position.x-touch2.position.x);
				oldDistY=Math.abs(touch1.position.y-touch2.position.y);
			}else if(touch2.id==event.touchPointID){
				touch2.position.x=event.stageX;
				touch2.position.y=event.stageY;
				checkZoom();
			}else{
				reset();
			}
		} 
		
		private function checkZoom():void{
			if(touch1.id==0||touch2.id==0)
				return;
			
			var newDistX:Number=Math.abs(touch1.position.x-touch2.position.x);
			var newDistY:Number=Math.abs(touch1.position.y-touch2.position.y);
			
			var scaleX:Number=(newDistX+100)/(oldDistX+100);
			var scaleY:Number=(newDistY+100)/(oldDistY+100);
			
			oldDistX=newDistX;
			oldDistY=newDistY;
			
			var we:WatcherEvent=new WatcherEvent(WatcherEvent.ZOOM);
			we.scaleX=scaleX;
			we.scaleY=scaleY;
			dispatchEvent(we);
		}
		
		private function onTouchEnd(event:TouchEvent):void{ 
			reset();
		}
		
		public function dispose():void{
		}
	}
}