package azura.common.algorithm.mover
{
	
	public class Cycler3 implements TimerI{
		
		private var fps_:int=-1;
		private var user:CycleUserI;
		public var loop:Boolean=true;
		
		public var currentFrame:int=0;		
		public var pause:Boolean;
		
		public function Cycler3(user:CycleUserI)
		{
			this.user=user;
			if(user==null)
				throw new Error();
		}
		
		public function get framePercent():Number
		{
			return currentFrame/user.frameCount;
		}
		
		public function set framePercent(value:Number):void
		{
			value=(value>=1)?0:value;
			currentFrame =value*user.frameCount;
		}
		
		public function get fps():int
		{
			return fps_;
		}
		
		public function set fps(value:int):void
		{
			if(fps_==value)
				return;
			
			fps_=value;			
			TimerFps.setTimer(fps_,this);
		}
		
		public function tick():void{
			if(pause)
				return;
			
			if(currentFrame>=user.frameCount){
				currentFrame=0;
			}
			
//			trace("show frame",currentFrame,"/",user.frameCount,this);
			user.showFrame(currentFrame);
			currentFrame++;
			
			if(currentFrame>=user.frameCount){
				if(loop==false){
					pause=true;
				}
				user.cycleEnd();
			}
		}
		
		public function dispose():void{
			TimerFps.removeTimer(this);
		}
	}
}