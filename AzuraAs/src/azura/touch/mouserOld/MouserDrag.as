package azura.touch.mouserOld
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
	
	public class MouserDrag
	{
		private var source:EventDispatcher;
		private var mouseDownAt:Point=new Point();
		private var isDown:Boolean;
		
		public var position:Point=new Point();
		public var delta:Point=new Point();
		
		public var listener:MouserDragI;
		
		public function MouserDrag(source:EventDispatcher,enableMouseOut:Boolean=true)
		{
			this.source=source;
			source.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			source.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			
			if(enableMouseOut)
				source.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
		}
		
		private function mouseDown(event:MouseEvent):void{
			
			isDown=true;
			mouseDownAt.x=event.stageX;
			mouseDownAt.y=event.stageY;
			source.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
//			trace("mouse move on",this);
			
			position=new Point(event.stageX-Statics.stage.stageWidth/2,event.stageY-Statics.stage.stageHeight/2);
			if(listener!=null)
				listener.onDragStart(this);
		}
		
		private function mouseMove(event:MouseEvent):void{
			
			if(!event.buttonDown){
				mouseUp(null);
				return;
			}

			position=new Point(event.stageX-Statics.stage.stageWidth/2,event.stageY-Statics.stage.stageHeight/2);
			delta=new Point(event.stageX-mouseDownAt.x,event.stageY-mouseDownAt.y);
			if(listener!=null)
				listener.onDragMove(this);
		}
		
		private function mouseOut(event:MouseEvent):void{
			mouseUp(event);
		}
		
		private function mouseUp(event:MouseEvent):void{
			
			if(!isDown)
				return;
			
			isDown=false;
			source.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
//			trace("mouse move off",this);
			
			var stage:Stage=Statics.stage;
			
			position=new Point(stage.mouseX-stage.stageWidth/2,stage.mouseY-stage.stageHeight/2);
			delta=new Point(stage.mouseX-mouseDownAt.x,stage.mouseY-mouseDownAt.y);
			if(listener!=null)
				listener.onDragEnd(this);
		}
		
		public function clear():void{
			isDown=false;
			source.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
		}
		
		public function dispose():void{
//			trace("dispose",this);
			source.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			source.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			source.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			source.removeEventListener(MouseEvent.MOUSE_OUT,mouseUp);
			source=null;
			listener=null;
		}
	}
}