package azura.common.ui.shine
{
	import azura.banshee.engine.Statics;
	
	import azura.common.algorithm.FastMath;
	import azura.touch.watcherOld.WatcherDrag;
	import azura.touch.watcherOld.WatcherEvent;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import mx.events.FlexEvent;
	
	import org.osflash.signals.Signal;
	
	public class RailDragger
	{
		private var target:DisplayObject;			
		private var wd:WatcherDrag;
		private var from:Point=new Point();
		private var to:Point=new Point();
		private var last:Point=new Point();
		
		private var la:Number;
		
		private var k:Number;
		
		public var onHit:Signal=new Signal();
		
		public function RailDragger(target:DisplayObject,toX:int,toY:int)
		{
			this.target=target;
			from.x=target.x;
			from.y=target.y;
			to.x=toX;
			to.y=toY;
			wd=new WatcherDrag(target,true);
			wd.addEventListener(WatcherEvent.DRAG_MOVE,onDragMove);
			wd.addEventListener(WatcherEvent.DRAG_END,onDragEnd);
			
			la=FastMath.dist(from.x,from.y,to.x,to.y);
		}
		
		private function onDragMove(we:WatcherEvent):void{
			
			we.delta.x/=Statics.stageScale;
			we.delta.y/=Statics.stageScale;
			
			var lb:Number=FastMath.dist(0,0,we.delta.x,we.delta.y);
			
			var a1:Number=we.delta.x*(to.x-from.x)+we.delta.y*(to.y-from.y);
			
			var cosC:Number=a1/la/lb;
			var lpro:Number=a1*la;
			
			if(isNaN(cosC)){
				
			}else if(cosC>=-1&&cosC<=0)
			{
				target.x=from.x;
				target.y=from.y;
			}else if(lb*cosC>=la){
				target.x=to.x;
				target.y=to.y;
				
				wd.clear();
				onHit.dispatch();
				setTimeout(onDragEnd,1000,null);
			}else{
				target.x=from.x+(to.x-from.x)*cosC*lb/la;
				target.y=from.y+(to.y-from.y)*cosC*lb/la;
			}
		}
		
		private function onDragEnd(we:WatcherEvent):void{
			target.x=from.x;
			target.y=from.y;
		}
	}
}