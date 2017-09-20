package azura.common.algorithm.mover
{
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	
	public class Easer
	{
		private var speed:Number;
		public var factor:int;
		
		private var current:Point=new Point();
		private var dest:Point=new Point();
		private var init:Boolean;
		
		public function Easer(speed:Number=10){
			this.speed=speed;
		}
		
		public function stop():void{
			dest=current.clone();
		}
		
		public function clear():void{
			current=dest.clone();
		}
		
		public function reset(xStart:int,yStart:int,xEnd:int,yEnd:int):void{
			init=true;
			
			current.x=xStart;
			current.y=yStart;
			dest.x=xEnd;
			dest.y=yEnd;
		}
		
		public function next():Point{
			if(current.equals(dest)){
				if(init){
					init=false;					
					return current.clone();
				}
				else
					return null;
			}
			if(Math.abs(Math.abs(current.x)-Math.abs(dest.x))<0.5){
				current.x=dest.x;
			}
			if(Math.abs(Math.abs(current.y)-Math.abs(dest.y))<0.5){
				current.y=dest.y;
			}
			current.x-=(current.x-dest.x)/speed*(factor+1);
			current.y-=(current.y-dest.y)/speed*(factor+1);
			init=false;
			return current.clone();
		}
	}
}