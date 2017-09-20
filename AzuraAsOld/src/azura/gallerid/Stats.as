package azura.gallerid
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Stats
	{
		private static var chunk:int=10;
		
		[Bindable]
		public var speed:int;
		
		private var timer:Timer;
		private var que:Vector.<int>=new Vector.<int>();
		private var length:int;
		private var total:int;
		public function Stats(seconds:int=1)
		{
			this.length=Math.max(seconds,1)*chunk;
			que.unshift(0);
			timer=new Timer(1000*seconds/chunk);
			timer.addEventListener(TimerEvent.TIMER,tick);
			timer.start();
		}
		
		private function tick(event:TimerEvent):void{
			speed=chunk*total/1024/que.length;
			
			if(que.length==length)
				total-=que.pop();
			if(que.length<length)
				que.unshift(0);			
		}
		
		public function add(data:int):void{
			que[0]+=data;
			total+=data;			
		}
	}
}