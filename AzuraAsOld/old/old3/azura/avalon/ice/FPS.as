package old.azura.avalon.ice
{
	import flash.utils.getTimer;

	public class FPS
	{
		private static var window:int=10;
		
		private static var que:Vector.<int>=new Vector.<int>();
		private static var sum:int;
		
		private static var lastTime:int;
				
		/**
		 * 
		 * @param passedTime in milliseconds
		 * 
		 */
		public static function tick(passedTime:int=0):void{
//			trace("delta="+passedTime);
			
			var newTime:int=getTimer();
			passedTime=newTime-lastTime;
			
			var current:int=1000/passedTime;
			que.push(current);			
			sum+=current;
			
			if(que.length>window){
				var head:int=que.shift();
				sum-=head;
			}
			
			lastTime=newTime;
		}
		
		public static function get fps():int{
			return sum/que.length;
		}
	}
}