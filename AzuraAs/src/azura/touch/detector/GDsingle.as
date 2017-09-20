package azura.touch.detector
{
	import azura.common.algorithm.FastMath;
	import azura.touch.TouchBox;
	import azura.touch.TouchRawI;
	import azura.touch.TouchStage;
	import azura.touch.gesture.GsingleI;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class GDsingle extends Gdetector
	{
		
		private var isDown:Boolean=false;
		
		private var travelDist:int;		
		private var lastX:Number;
		private var lastY:Number;
		
		private var lastSelectTime:int;
		
		public function GDsingle(user:GsingleI){
			super(user);
		}
		
		public function get target():GsingleI{
			return user as GsingleI;
		}
		
		override public function handDown(touchId:int, x:Number, y:Number):void
		{
//			trace("down",touchId,this);
			isDown=true;
			lastX=x;
			lastY=y;
			travelDist=0;
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
			if(!isDown){
				trace("up but not down",touchId,this);
				return ;
			}
			
			if(!tooFar && !tooFast){
//				trace("single",touchId,this);
				target.singleClick(x,y);
				lastSelectTime=getTimer();
			}
			
			isDown=false;
			
		}
		
		override public function handOut(touchId:int):void
		{
			isDown=false;
		}
		
		private function get tooFar():Boolean{
			return travelDist>TouchStage.fingerRadius*2;
		}
		
		private function get tooFast():Boolean{
			return (getTimer()-lastSelectTime)<500;
		}
	}
}