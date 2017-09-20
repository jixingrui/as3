package azura.touch.watcherOld
{
	import azura.banshee.engine.Statics;
	
	import azura.touch.watcherOld.WatcherEvent;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	import mx.core.FlexGlobals;
	
	public class WatcherDrag extends EventDispatcher
	{
		private var source:EventDispatcher;
		private var mouseDownAt:Point=new Point();
		private var isDown:Boolean;
		
		public var position:Point=new Point();
		public var delta:Point=new Point();
		
		public var listener:WatcherDragI;
		
		public function WatcherDrag(target:EventDispatcher,enableMouseOut:Boolean=true)
		{
			this.source=target;
			target.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			target.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			
			//			if(!(target is Stage))
			if(enableMouseOut)
				target.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
		}
		
		private function mouseDown(event:MouseEvent):void{
			//			event.stopImmediatePropagation();
			
			isDown=true;
			mouseDownAt.x=event.stageX;
			mouseDownAt.y=event.stageY;
			source.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			
			//			var stage:Stage=FlexGlobals.topLevelApplication.stage;
			var we:WatcherEvent=new WatcherEvent(WatcherEvent.DRAG_START);
			we.position=new Point(event.stageX-Statics.stage.stageWidth/2,event.stageY-Statics.stage.stageHeight/2);
			dispatchEvent(we);
			if(listener!=null)
				listener.onDragStart(we);
		}
		
		private function mouseMove(event:MouseEvent):void{
			
			if(!event.buttonDown){
				mouseUp(null);
				return;
			}
			//			event.stopImmediatePropagation();
			
			//			var stage:Stage=FlexGlobals.topLevelApplication.stage;
			var we:WatcherEvent=new WatcherEvent(WatcherEvent.DRAG_MOVE);
			we.position=new Point(event.stageX-Statics.stage.stageWidth/2,event.stageY-Statics.stage.stageHeight/2);
			we.delta=new Point(event.stageX-mouseDownAt.x,event.stageY-mouseDownAt.y);
			dispatchEvent(we);
			if(listener!=null)
				listener.onDragMove(we);
		}
		
		private function mouseOut(event:MouseEvent):void{
			//			trace("mouse out",event.target,this);
			mouseUp(event);
		}
		
		private function mouseUp(event:MouseEvent):void{
			//			event.stopImmediatePropagation();
			
			if(!isDown)
				return;
			
			isDown=false;
			source.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			
			var stage:Stage=Statics.stage;
			
			var we:WatcherEvent=new WatcherEvent(WatcherEvent.DRAG_END);
			we.position=new Point(stage.mouseX-stage.stageWidth/2,stage.mouseY-stage.stageHeight/2);
			we.delta=new Point(stage.mouseX-mouseDownAt.x,stage.mouseY-mouseDownAt.y);
			dispatchEvent(we);
			if(listener!=null)
				listener.onDragEnd(we);
		}
		
		public function clear():void{
			isDown=false;
			source.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
		}
		
		public function dispose():void{
			source.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			source.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			source.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			source.removeEventListener(MouseEvent.MOUSE_OUT,mouseUp);
			source=null;
		}
	}
}