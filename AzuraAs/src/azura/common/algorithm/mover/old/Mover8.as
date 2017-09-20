package azura.common.algorithm.mover.old
{
	import azura.common.algorithm.FastMath;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class Mover8
	{
		private static var speed:int=2;
		private static var frameRate:int=60;		
		
		private var xNow:Number=0, yNow:Number=0;
		private var xDest:Number=0, yDest:Number=0;
		
		private var user:Mover8UserI;
		private var timer:Timer;
		
		public function Mover8(user:Mover8UserI,useTimer:Boolean=true):void{
			this.user=user;
			if(useTimer){
				timer=new Timer(1000/frameRate);
				timer.addEventListener(TimerEvent.TIMER,tick,false,0,true);
			}
		}
		
		public function stop():void{
			xDest=xNow;
			yDest=yNow;
		}
		
		public function walkTo(x:Number,y:Number):void{
			//			trace('from: '+xNow+','+yNow+' to: '+x+','+y);
			
			xDest=x;
			yDest=y;
			
			user.turn(dxyToFacing24(xDest-xNow,yDest-yNow)/3);
			if(timer!=null&&!timer.running){
				timer.start();
			}
		}
		
		public function jumpTo(x:Number, y:Number):void
		{			
			xDest=x;
			yDest=y;
			xNow=x;
			yNow=y;
			
			if(timer!=null)
				timer.stop();
			user.move(x,y);
			user.stop();
		}
		
		public function frameHandler():void{
			if(xDest==xNow && yDest==yNow){
				
			}else{
				tick(null);
			}
		}
		
		public function tick(event:TimerEvent=null):void{
			next();
			user.move(xNow,yNow);
			
			if(xNow==xDest&&yNow==yDest){
				if(timer!=null)
					timer.stop();
				user.stop();
			}			
		}
		
		private function next():void
		{			
			//x
			var dx:Number=xDest - xNow;
			var sx:Number=FastMath.sign(dx);
			var bx:Number=Math.abs(dx);
			if (bx > 1)
			{
				xNow+=sx * Math.sqrt(bx)/speed;
			}
			else
			{
				xNow=xDest;
			}
			
			//y
			var dy:Number=yDest - yNow;
			var sy:Number=FastMath.sign(dy);
			var by:Number=Math.abs(dy);
			if (by > 1)
			{
				yNow+=sy * Math.sqrt(by)/speed;
			}
			else
			{
				yNow=yDest;
			}
		}
		
		
		private static function dxyToFacing24(dx:int,dy:int):int{
			var angle:Number=Math.atan2(dy,dx)*180/Math.PI+180;
			return ((angle+22.5)/15)%24;
		}
		
	}
}
