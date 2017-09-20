package azura.common.algorithm.mover
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	public class Cycler implements TimerI{
		
		private var target_:FramerI;
		private var _fps:int=12;
		private var nextFrame:int=0;
		
		public function Cycler()
		{
//			this.target_=target;
			TimerFps.setTimer(_fps, this);
			tick();
		}
		
		public function get fps():int
		{
			return _fps;
		}
		
		public function set fps(value:int):void
		{
			if(_fps==value)
				return;
			
			TimerFps.setTimer(value,this);
			_fps = value;
		}
		
		public function get target():FramerI
		{
			return target_;
		}
		
		public function set target(value:FramerI):void
		{
			target_ = value;
			if(target_!=null)
				nextFrame=target_.nextFrameIdx;
			else
				trace("empty target",this);
		}
		
		public function tick():void{
			if(target_==null){
				//				trace("no target",this);
				return;
			}
			
			if(nextFrame<target_.frameCount){
				target_.showFrame(nextFrame);
				nextFrame++;
			}else{
				target_.showFrame(0);
				nextFrame=1;
			}
		}
		
		public function pause():void{
			
		}
		
		public function resume():void{
			
		}
		
		public function dispose():void{
			TimerFps.removeTimer(this);
		}
		
	}
}