package maze.tween
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	public class TweenPoint
	{
		private var current:Point=new Point();
		
		private var dest:Point=new Point();
		
		private var tween:TweenMax;
		
		public var onStep:Signal=new Signal(Number,Number);
		
		public var linear:Boolean;
		
		public function TweenPoint()
		{
		}
		
		public function go(startX:Number,startY:Number,endX:Number,endY:Number):void{
			current.x=startX;
			current.y=startY;
			dest.x=endX;
			dest.y=endY;
			reset();
		}
		
		public function from(x:Number,y:Number):void{
			current.x=x;
			current.y=y;
			reset();
		}
		
		public function to(x:Number,y:Number):void{
			dest.x=x;
			dest.y=y;
			reset();
		}
		
		public function stop():void{
			if(tween != null && tween.isActive()){
				tween.kill();
				tween=null;
			}
		}
		
		private function reset():void{
			stop();
			if(linear)
				tween=TweenMax.to(current,60,{x:dest.x,y:dest.y,onUpdate:onUpdate_,useFrames:true,ease:Linear.ease});
			else
				tween=TweenMax.to(current,60,{x:dest.x,y:dest.y,onUpdate:onUpdate_,useFrames:true});
		}
		
		private function onUpdate_():void{
			onStep.dispatch(current.x,current.y);
		}
	}
}