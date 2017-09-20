package azura.banshee.layers.zpano
{
	import azura.banshee.engine.Statics;
	
	import azura.touch.watcherOld.WatcherDrag;
	import azura.touch.watcherOld.WatcherEvent;
	
	import flash.geom.Point;
	
	public class MouseDragScreen 
	{
		private var host:LayerZpanoPure;
		
		private var downRoot:Point;
		
		private var wd:WatcherDrag;
		
		public function MouseDragScreen(host:LayerZpanoPure)
		{
			this.host=host;
			
			wd=new WatcherDrag(Statics.stage,false);
			wd.addEventListener(WatcherEvent.DRAG_START,onDragStart);
			wd.addEventListener(WatcherEvent.DRAG_MOVE,onDragMove);
			wd.addEventListener(WatcherEvent.DRAG_END,onDragEnd);
		}
		public function onDragStart(we:WatcherEvent):void{
			host.mouseDown(we.position.x,we.position.y);
		}
		public function onDragMove(we:WatcherEvent):void{
			host.mouseMove(we.position.x,we.position.y);
		}
		public function onDragEnd(we:WatcherEvent):void{
			host.mouseUp(we.position.x,we.position.y);
		}

		public function dispose():void{
			wd.removeEventListener(WatcherEvent.DRAG_START,onDragStart);
			wd.removeEventListener(WatcherEvent.DRAG_MOVE,onDragMove);
			wd.removeEventListener(WatcherEvent.DRAG_END,onDragEnd);
			wd.dispose();
			wd=null;
			host=null;
		}
	}
}