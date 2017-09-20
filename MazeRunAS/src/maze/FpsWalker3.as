package maze
{
	
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.mover.EnterFrame;
	import azura.common.algorithm.mover.EnterFrameI;
	import azura.common.algorithm.mover.FPS;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.algorithm.pathfinding.PathWalker;
	import azura.common.algorithm.pathfinding.astar.AstarMapI;
	
	import flash.geom.Point;
	
	public class FpsWalker3 implements EnterFrameI
	{
		/**
		 * n pixels/second.
		 */
		public var speed:Number=0;
		
		public var currentPoint:Point;
		
		private var path:PathWalker;
		public var map:AstarMapI;
		private var user:MotorI;
		
		private var stand_go:Boolean=true;
		
		public var going:Boolean;
		
		public var smooth:Boolean=true;
		
		public function FpsWalker3(user:MotorI){
			this.user=user;
			path=new PathWalker(user);
		}
		
		public function jumpStart(x:int,y:int):void{
			going=false;
			currentPoint=new Point(x,y);
			path.jumpStart(currentPoint.x,currentPoint.y);
		}
		
		public function appendPoint(p:Point):void{
			ensureTimer();
			path.appendPoint(p);
		}
		
		public function appendPath(track:Vector.<Point>):void{
			if(track==null||track.length==0){
				trace("path is empty",this);
				return;
			}
			
			ensureTimer();
			path.appendPath(track);
		}
		
		private function ensureTimer():void{
			if(going==false){
				going=true;
				EnterFrame.addListener(this);
			}
			stand_go=false;
			if(user!=null)
				user.go();
		}
		
		public function stop():void{
			going=false;
			EnterFrame.removeListener(this);
			
			if(stand_go==false){
				stand_go=true;
				if(user!=null)
					user.stop();
			}
		}
		
		//=========== frame ===========
		public function enterFrame():void{
			tick();
		}
		
		public function tick():void{
			if(going==false)
				return;
			
			//			var rest:int=path.lastAngle%90;
			//			var rad:Number=FastMath.angle2radian(rest);
			//			var factor:Number=1/FastMath.cos(rad);
			//			trace("angle",path.lastAngle,"factor",factor,this);			
			
			var step:Number=speed/FPS.getFps();
			//			var step:Number=speed/60;
			if(smooth){
				if(path.currentDist>200){
					step*=1.1;
				}else{
					step*=0.9;
				}
			}
			//			if(smooth){
			////				trace("dist=",path.currentDist,this);
			//				var factor:Number=1+path.currentDist/1000;
			//				step*=factor;
			//			}
			
			//			step*=1.2;
			var stepI:int=FastMath.roundByChance(step);
			
			//			trace("stepI",stepI,"step",step,this);
			
			if(stepI==0){
				return;
			}
			
			var next:Point=path.next(stepI);
			if(next!=null){
				currentPoint=next;
				if(user!=null)
					user.jumpTo(currentPoint.x,currentPoint.y);
			}else{
				stop();			
			}
		}
		
		
		//============= support ===========
		
		public function get destPoint():Point{
			return path.tailPoint;
		}
		
		public function clear():void{
			map=null;
			path.clear();
		}
		
		
		public function get pathLength():int{
			return path.pathLength;
		}
		
	}
}