package azura.common.algorithm.mover
{
	import flash.utils.getTimer;

	public class FPS
	{
		private static var window:int=20;		
		private static var que:Vector.<int>=new Vector.<int>();
		private static var sum:int;		
		private static var lastTime:int;
		
		public static function tick(time:int):void{
			
			var passedTime:int=time-lastTime;
			
			var current:int=1000/passedTime;
			que.push(current);			
			sum+=current;
			
			if(que.length>window){
				var head:int=que.shift();
				sum-=head;
			}
			
			lastTime=time;
		}
		
		public static function getFps():int{
			return sum/que.length;
		}
	}
}