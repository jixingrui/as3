package azura.common.ui.shine
{
	import azura.banshee.engine.Statics;
	
	import azura.common.algorithm.FastMath;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	import azura.touch.watcherOld.WatcherDrag;
	import azura.touch.watcherOld.WatcherEvent;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import mx.events.FlexEvent;
	
	import org.osflash.signals.Signal;
	
	public class RailDragger2
	{
		private var target:RailDragger2I;			
		//		private var wd:WatcherDrag;
		private var from:Point=new Point();
		private var to:Point=new Point();
		private var last:Point=new Point();
		
		private var la:Number;
		
		private var k:Number;
		
		public var onHit:Signal=new Signal();
		
		public function RailDragger2(target:RailDragger2I,fromX:int,fromY:int,toX:int,toY:int)
		{
			this.target=target;
			from.x=fromX;
			from.y=fromY;
			to.x=toX;
			to.y=toY;
			//			wd=new WatcherDrag(target,true);
			//			wd.addEventListener(WatcherEvent.DRAG_MOVE,onDragMove);
			//			wd.addEventListener(WatcherEvent.DRAG_END,onDragEnd);
			
			la=FastMath.dist(from.x,from.y,to.x,to.y);
		}
		
		//		public function dragStart():Boolean
		//		{
		//			return false;
		//		}
		
		public function dragMove(dx:Number, dy:Number):Boolean
		{
			
			var lb:Number=FastMath.dist(0,0,dx,dy);
			
			var a1:Number=dx*(to.x-from.x)+dy*(to.y-from.y);
			
			var cosC:Number=a1/la/lb;
			var lpro:Number=a1*la;
			
			if(isNaN(cosC)){
				
			}else if(cosC>=-1&&cosC<=0)
			{
				//				target.x=from.x;
				//				target.y=from.y;
				target.move(from.x,from.y);
			}else if(lb*cosC>=la){
				//				target.x=to.x;
				//				target.y=to.y;
				target.move(to.x,to.y);
				
				//				wd.clear();
				onHit.dispatch();
//				setTimeout(dragEnd,1000);
			}else{
				//				target.x=from.x+(to.x-from.x)*cosC*lb/la;
				//				target.y=from.y+(to.y-from.y)*cosC*lb/la;
				var tx:Number=from.x+(to.x-from.x)*cosC*lb/la;
				var ty:Number=from.y+(to.y-from.y)*cosC*lb/la;
				target.move(tx,ty);
			}
			return false;
		}
		
		public function dragEnd():Boolean
		{
//			target.x=from.x;
//			target.y=from.y;
//			target.move(from.x,from.y);
			return false;
		}
		
		//		public function get touchBox():TouchBox
		//		{
		//			return null;
		//		}
		//		
		//		public function set touchBox(box:TouchBox):void
		//		{
		//		}
	}
}