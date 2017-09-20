package maze.control
{
	import azura.common.algorithm.FastMath;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	import maze.GameDisplay;
	import maze.tween.FrameStrider;
	import maze.tween.TweenPoint;
	
	public class Dragger implements GdragI
	{
		private var canvas:GameDisplay;
		private var start:Point=new Point();
		//		public var front:Point=new Point();
//		private var tpView:TweenPoint=new TweenPoint();
		public function Dragger(canvas:GameDisplay)
		{
			this.canvas=canvas;
//			tpView.onStep.add(canvas.look);
		}
		
		//		private function look(p:Point):void{
		//			canvas.look(p.x,p.y);
		//		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{			
			canvas.walkTowards(x,y);
//			tpView.stop();
			canvas.clickEnabled=false;
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			canvas.walkTowards(x,y);
//			tpView.stop();
			return false;
		}
		
		public function dragEnd():Boolean
		{
//			trace("drag end",this);
//			if(canvas.hero.motor.going==true)
//				return false;
			
			
			canvas.hero.stopWalking();
			//			canvas.front=new Point(0,0);
			canvas.tpView.stop();
			
			//			var angle:int=canvas.hero.actor.zbox.angle;
			//			canvas.front=FastMath.angle2Xy(angle,400);
			
			canvas.heroMoved();
			canvas.clickEnabled=true;
			
			//			tpView.go(canvas.spaceGround.xView,canvas.spaceGround.yView,canvas.hero.body.x,canvas.hero.body.y);
			//			tpView.go(canvas.spaceGround.xView,canvas.spaceGround.yView,canvas.hero.body.x,canvas.hero.body.y);
			return false;
		}
		
		public function get touchBox():TouchBox
		{
			return null;
		}
		
		public function set touchBox(box:TouchBox):void
		{
		}
	}
}