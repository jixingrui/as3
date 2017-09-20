package azura.touch.detector
{
	import azura.common.algorithm.FastMath;
	import azura.touch.TouchRawI;
	import azura.touch.TouchStage;
	import azura.touch.gesture.GdragI;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class GDdrag extends Gdetector
	{
		public function GDdrag(user:GdragI)
		{
			super(user);
		}
		
		private var dragId:int;
		private var downPos:Point;
		private var isDragging:Boolean;
		private var timer:Timer;
		
		public function get target():GdragI{
			return user as GdragI;
		}
		
		override public function handDown(touchId:int, x:Number, y:Number):void
		{
			dragId=touchId;
			downPos=new Point(x,y);
			timer=new Timer(300,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			timer.start();
		}
		
		private function onTimer(te:TimerEvent):void{
			removeTimer();
			if(isDragging==false){
				isDragging=true;
				target.dragStart(downPos.x,downPos.y);	
			}
		}
		
		private function removeTimer():void{
			if(timer==null)
				return;
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			timer.stop();
			timer=null;
		}
		
		override public function handMove(touchId:int, x:Number, y:Number):void
		{
			if(dragId!=touchId)
			{
				end();
				return;
			}
			
			if(isDragging==false && downPos!=null){
				var dist:Number=FastMath.dist(x,y,downPos.x,downPos.y);
				if(dist>TouchStage.fingerRadius){
					isDragging=true;
					target.dragStart(x,y);			
					target.dragMove(x,y,x-downPos.x,y-downPos.y);
					return ;
				}
			}else if(isDragging){
				target.dragMove(x,y,x-downPos.x,y-downPos.y);
				return ;
			}
		}
		
		override public function handUp(touchId:int, x:Number, y:Number):void
		{
			end();
		}
		
		override public function handOut(touchId:int):void
		{
			end();
		}
		
		private function end():void{
			if(isDragging){
				target.dragEnd();
				if(target.touchBox!=null)
					target.touchBox.dropSelf();
			}
			isDragging=false;
			downPos=null;
			removeTimer();
		}
	}
}