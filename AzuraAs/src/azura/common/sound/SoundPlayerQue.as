package azura.common.sound  
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class SoundPlayerQue extends SpeexPlayerCore
	{
		private static var que:Vector.<SoundPlayerQue>=new Vector.<SoundPlayerQue>();
		private static var currentPlayer:SoundPlayerQue;
		private static var paused:Boolean;
				
		public static function play(data:ByteArray,self:Boolean=false):void{
			if(data==null || data.bytesAvailable==0)
			{
				trace("Empty sound cannot be played!");
				return;
			}
			
			//stop self
			if(currentPlayer!=null && currentPlayer.self){
				currentPlayer.stop();
				currentPlayer=null;
			}
			
			que.push(new SoundPlayerQue(data,self));
			playNext();
		}
		
		public static function playNext():void{
			if(paused || currentPlayer!=null){
				return;
			}else if(que.length>0){
				currentPlayer=que.shift()
				currentPlayer.play();
			}
		}
				
		public static function pause():void{
			paused=true;
			if(currentPlayer!=null)
				currentPlayer.pause();
		}
		
		public static function resume():void{
			paused=false;
			if(currentPlayer!=null){
				if(!currentPlayer.resume()){
					playNext();					
				}
			}
		}
				
		//---------------------------------------------------
		
		public var self:Boolean;
		public function SoundPlayerQue(data:ByteArray,self:Boolean)
		{
			super(data);
			this.self=self;
		}
		override protected function onSoundComplete(event:Event):void{
			super.onSoundComplete(event);
			currentPlayer=null;
			playNext();
		}
	}
}
