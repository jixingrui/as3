package azura.common.algorithm.pathfinding
{
	
	import azura.common.algorithm.mover.EnterFrame;
	import azura.common.algorithm.mover.EnterFrameI;
	import azura.common.algorithm.mover.FPS;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.algorithm.mover.TimerFps;
	import azura.common.algorithm.pathfinding.astar.AstarMapI;
	
	import flash.geom.Point;
	
	public class FpsWalkerOld implements MotorI,EnterFrameI
	{
		/**
		 *stride when framerate==60 
		 */
		private static var stride60:Number=2;
		/**
		 * n pixels/tick.
		 */
		public var stride:Number=stride60;
		
		public var currentPoint:Point;
		private var nextPoint:Point;
		
		private var path:PathWalker;
		public var map:AstarMapI;
		private var user:MotorI;
		
		private var stand_go:Boolean=true;
		
		public function FpsWalkerOld(user:MotorI){
			this.user=user;
			path=new PathWalker(this);
			EnterFrame.addListener(this);
		}
		
		public function enterFrame():void{
			tick();
		}
		
		public function get destPoint():Point{
			return path.tailPoint;
		}
		
		public function clear():void{
//			map=null;
//			user=null;
//			path.clear();
		}
		
		public function goAlong(track:Vector.<Point>):void{
			if(track==null||track.length==0)
				throw new Error("Motor: path is empty");
			
			EnterFrame.addListener(this);
			
			path.appendPath(track);
			
			currentPoint=path.next(1);//cannot be null
			nextPoint=path.next(1);//can be null
			
			path.next(stride);
			stand_go=false;
			if(user!=null)
				user.go();
		}
		
		public function jump(x:int,y:int):void{
			
			currentPoint=new Point(x,y);
			path.jumpStart(x,y);
			
//			path.jump(currentPoint.x,currentPoint.y);
			
			tick();
			tick();
		}
		
//		public function stop():void{
//			EnterFrame.removeListener(this);
//		}
		
		public function tick():void{
			
			var step:int=Math.round(stride*60/FPS.getFps());
			
			var next:Point=path.next(step);
			if(next!=null){
				
				currentPoint=next;
				
				if(user!=null)
					user.jumpTo(currentPoint.x,currentPoint.y);
				
			}else{
				if(stand_go==false){
					stand_go=true;
					if(user!=null)
						user.stop();
				}
			}
		}
		
		
		public function jumpTo(x:Number, y:Number):void
		{
			if(user!=null)
				user.jumpTo(x,y);
		}
		
		public function turnTo(angle:int):int
		{
			if(user!=null)
				return user.turnTo(angle);
			else
				return 0;
		}
		
		public function go():void
		{
			if(user!=null)
				user.go();
		}
		
		public function stop():void
		{
			if(user!=null)
				user.stop();
		}
		
		public function get isIdle():Boolean{
			return stand_go;
		}
		
		public function get pathLength():int{
			return path.hopList.length;
		}
	}
}