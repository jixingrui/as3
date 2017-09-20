package azura.banshee.zbox3.editor.dish
{
	import azura.common.algorithm.mover.EnterFrame;
	import azura.common.algorithm.mover.EnterFrameI;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.algorithm.pathfinding.PathWalker;
	import azura.common.algorithm.pathfinding.astar.AstarMapI;
	
	import flash.geom.Point;
	
	public class MotorByFpsFast implements MotorI,EnterFrameI
	{
		public var currentPoint:Point;
		
		private var motor:PathWalker;
		public var map:AstarMapI;
		private var user:MotorI;
		
		private var stand_go:Boolean=true;
		
		public function MotorByFpsFast(user:MotorI, xStart:int=0, yStart:int=0){
			this.user=user;
			motor=new PathWalker(this);
			start(xStart,yStart);
			EnterFrame.addListener(this);
		}
		
		public function get destPoint():Point{
			return motor.tailPoint;
		}
		
		public function clear():void{
			EnterFrame.removeListener(this);
			map=null;
			user=null;
			motor=new PathWalker();
		}
		
		public function goTo(x:Number,y:Number):void{
			var track:Vector.<Point>=new Vector.<Point>();
			var dest:Point=new Point(x,y);
			track.push(dest);
			goAlong(track);
		}
		
		public function goAlong(track:Vector.<Point>):void{
			if(track==null||track.length==0)
				throw new Error("Motor: path is empty");
			
			motor.appendPath(track);
			
			stand_go=false;
			if(user!=null)
				user.go();
		}
		
		public function start(x:int,y:int):void{
			currentPoint=new Point(x,y);
			motor.jumpStart(currentPoint.x,currentPoint.y);
		}
		
		public function enterFrame():void{
			
			var step:int=Math.sqrt(motor.currentDist);
			step=Math.max(3,step);
			
			var next:Point=motor.next(step);
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
			return motor.pathLength;
		}
	}
}