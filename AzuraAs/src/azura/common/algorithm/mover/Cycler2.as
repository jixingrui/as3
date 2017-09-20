package azura.common.algorithm.mover
{
	
	
	public class Cycler2 implements TimerI{
		
		private var _fps:int=12;
		private var user:CycleUserI;
		//		private var nextFrame:int=0;
		private var currentFrame_:int=0;
		private var frameCount:int=0;
		
		private var registered:Boolean;
		private var registerFps:int;
		private var paused:Boolean;
		
		public var cycle:Boolean=true;
		
		public function Cycler2()
		{
		}
		
		public function get currentFrame():int
		{
			return currentFrame_;
		}
		
		private function setCurrentFrame(value:int):void
		{
			currentFrame_ = value%frameCount;
			if(currentFrame_!=value)
				trace("warning: frame overflow",value,"/",frameCount,this);
		}
		
		public function get framePercent():Number
		{
			//			trace("get frame percent=",currentFrame/frameCount,"by",currentFrame,"/",frameCount,this);
			return currentFrame/frameCount;
		}
		
		public function set framePercent(value:Number):void
		{
			//			currentFrame_ = (value*frameCount)%frameCount;
			value=(value==1)?0:value;
			setCurrentFrame(value*frameCount);
			//			trace("set frame percent=",value,"to",currentFrame,"/",frameCount,this);
			//			trace("frame percent=",value,"frame=",currentFrame,this);
		}
		
//		public function advance():void{
//			setCurrentFrame(currentFrame+1);
//		}
		
		public function get fps():int
		{
			return _fps;
		}
		
		public function set fps(value:int):void
		{
			//			trace("set fps to",value,this);
			
			if(_fps==value)
				return;
			
			if(!registered){
				_fps=value;
				return;
			}
			

			TimerFps.setTimer(value,this);
			_fps = value;
		}
		
		public function register(user:CycleUserI, frameCount:int):void
		{
			if(user==null||frameCount<1)
				throw new Error();
			
			this.user = user;
			this.frameCount=frameCount;
			
			if(!registered){
				registered=true;
				TimerFps.setTimer(_fps,this);
			}
			
			//			tick();
		}
		
		public function unregister():void{
			if(registered){
				TimerFps.removeTimer(this);
				registered=false;				
			}
		}
		
		//		public function playFrame(frame:int):void{
		//			currentFrame=frame%frameCount;
		//			//			tick();
		//		}
		
		public function tick():void{
			if(user==null)
				throw new Error();
			
			if(paused)
				return;
			
			//			if(currentFrame>=frameCount){
			//				currentFrame=0;
			//			}
			//			currentFrame_=nextFrame;
			user.showFrame(currentFrame);
			//			nextFrame++;
			currentFrame_++;
			if(currentFrame>=frameCount){
				user.cycleEnd();
					if(cycle==false){
						unregister();
						return;
					}
				
				currentFrame_=0;
			}
			setCurrentFrame(currentFrame);
//			setCurrentFrame((currentFrame+1)%frameCount);
		}
		
		public function pause():void{
			paused=true;
		}
		
		public function resume():void{
			paused=false;	
		}
		
	}
}