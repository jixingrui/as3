package azura.common.algorithm.mover.old
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import azura.common.algorithm.mover.FramerI;
	
	public class PlayerOld implements PlayerI
	{
		private var timer:Timer=new Timer(1000/12);
		private var framer:FramerI;
		private var repeat:Boolean;
		private var currentFrame:int;
		private var onDone:Function;
		
		public function PlayerOld(){
			timer.addEventListener(TimerEvent.TIMER,tick);
		}
		
		public function set target(value:FramerI):void{
			framer=value;
		}
		
		private function tick(event:TimerEvent):void{
			if(currentFrame<framer.frameCount){
				framer.showFrame(currentFrame);
				currentFrame++;
			}else{
				currentFrame=0;
				if(!repeat || framer.frameCount<2){
					timer.stop();
					if(onDone!=null){
						onDone.call();
						onDone=null;
					}
				}
				else
					tick(null);
			}
		}
		
		public function get isPlaying():Boolean{
			return timer.running;
		}
		
		public function playOnce(onDone:Function):void{
			this.onDone=onDone;
			currentFrame=0;
			repeat=false;
			timer.start();
		}
		
		public function playCycle():void{
			currentFrame=0;
			repeat=true;
			timer.start();
		}
		
		public function pause():void{
			timer.stop();
		}
		
		public function resume():void{
			timer.start();
		}
		
		public function play(cycle:Boolean=true,restart:Boolean=false):void{
			repeat=cycle;
			if(restart)
				currentFrame=0;
			timer.start();
		}
	}
}