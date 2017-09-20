package azura.touch.mouserOld
{
	import azura.common.algorithm.FastMath;
	import azura.touch.watcherOld.Touch;
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
	
	public class MouserZoom
	{
		private var source:EventDispatcher;
		
		private var touch1:Touch=new Touch();
		private var touch2:Touch=new Touch();
		
		//		private var oldDistX:Number;
		//		private var oldDistY:Number;
		
		//		public var scaleX:Number;
		//		public var scaleY:Number;
		
		private var lastScaleX:Number=1;
		private var lastScaleY:Number=1;
		
		public var listener:MouserZoomI;
		
		//		private var touch1Start:Touch;
		//		private var touch2Start:Touch;
		
		public function MouserZoom(target:EventDispatcher)
		{
			this.source=target;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			target.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
			target.addEventListener(TouchEvent.TOUCH_END, onTouchEnd); 
		}
		
		private function reset():void{
			touch1.clear();
			touch2.clear();
			lastScaleX=1;
			lastScaleY=1;
			//			oldDistX=NaN;
			//			oldDistY=NaN;
		}
		
		private function onTouchMove(event:TouchEvent):void{
			//			trace("touch",event.touchPointID,this);
			if(touch1.id==0){
				//register touch1
				touch1.id=event.touchPointID;
				touch1.start.x=event.stageX;
				touch1.start.y=event.stageY;
				touch1.position.x=event.stageX;
				touch1.position.y=event.stageY;
			}else if(touch1.id==event.touchPointID){
				//move touch1
				touch1.position.x=event.stageX;
				touch1.position.y=event.stageY;
				checkZoom();
			}else if(touch2.id==0){
				//register touch2
				touch2.id=event.touchPointID;
				touch2.start.x=event.stageX;
				touch2.start.y=event.stageY;
				touch2.position.x=event.stageX;
				touch2.position.y=event.stageY;
				
				//				oldDistX=Math.abs(touch1.position.x-touch2.position.x);
				//				oldDistY=Math.abs(touch1.position.y-touch2.position.y);
			}else if(touch2.id==event.touchPointID){
				//move touch2
				touch2.position.x=event.stageX;
				touch2.position.y=event.stageY;
				checkZoom();
			}else{
				//more than 2 touches detected
				reset();
			}
		} 
		
		private function checkZoom():void{
			if(touch1.id==0||touch2.id==0||listener==null)
				return;
			
			//			var newDistX:Number=Math.abs(touch1.position.x-touch2.position.x);
			//			var newDistY:Number=Math.abs(touch1.position.y-touch2.position.y);
			
			var oldDistX:Number=FastMath.dist(touch1.start.x,0,touch2.start.x,0);
			var newDistX:Number=FastMath.dist(touch1.position.x,0,touch2.position.x,0);
			
			var oldDistY:Number=FastMath.dist(0,touch1.start.y,0,touch2.start.y);
			var newDistY:Number=FastMath.dist(0,touch1.position.y,0,touch2.position.y);
			
			//			trace("dist",newDistX,newDistY,this);
			
			var scaleX:Number=(newDistX+100)/(oldDistX+100);
			var scaleY:Number=(newDistY+100)/(oldDistY+100);
			
			//			oldDistX=newDistX;
			//			oldDistY=newDistY;
			
			listener.onZoom(scaleX/lastScaleX,scaleY/lastScaleY);
			
			lastScaleX=scaleX;
			lastScaleY=scaleY;
		}
		
		private function onTouchEnd(event:TouchEvent):void{ 
			reset();
		}
		
		public function dispose():void{
			source.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
			source.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd); 
			source=null;
			listener=null;
		}
	}
}