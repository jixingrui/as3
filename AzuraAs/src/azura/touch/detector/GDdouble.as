package azura.touch.detector
{
	import azura.common.algorithm.FastMath;
	import azura.touch.TouchRawI;
	import azura.touch.TouchStage;
	import azura.touch.gesture.GdoubleI;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class GDdouble extends Gdetector
	{
		public function GDdouble(user:GdoubleI)
		{
			super(user);
		}
		
		public function get target():GdoubleI{
			return user as GdoubleI;
		}
		
		private var idle_down_up:int=0;
		private var downPos:Point;
		private var downTime:int;
		
		private var travelDist:int;		
		private var lastX:Number;
		private var lastY:Number;
		
		override public function handDown(touchId:int, x:Number, y:Number):void
		{
			if(idle_down_up==0 || (getTimer()-downTime)>1000){
				idle_down_up=1;
				downTime=getTimer();
				downPos=new Point(x,y);
				lastX=x;
				lastY=y;
				travelDist=0;
//				trace("start",this);
			}
		}
		
		override public function handMove(touchId:int, x:Number, y:Number):void
		{
			travelDist+=Math.abs(x-lastX);
			travelDist+=Math.abs(y-lastY);
			lastX=x;
			lastY=y;
		}
		
		override public function handUp(touchId:int, x:Number, y:Number):void
		{
			if(tooFar||tooSlow){
				reset();
			}else if(idle_down_up==1){
				idle_down_up=2;
			}else if(idle_down_up==2){
				target.doubleClick();
				reset();
			}
		}
		
		private function get tooFar():Boolean{
			return travelDist>TouchStage.fingerRadius*2;
		}
		
		private function get tooSlow():Boolean{
			return (getTimer()-downTime)>1000;
		}
		
		private function reset():void{
			idle_down_up=0;
		}
		
		override public function handOut(touchId:int):void
		{
			reset();
		}
	}
}