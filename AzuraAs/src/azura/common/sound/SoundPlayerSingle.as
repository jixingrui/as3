package azura.common.sound
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class SoundPlayerSingle extends SpeexPlayerCore
	{
		private static var current:SoundPlayerSingle;
		
		public static function play(mp3:ByteArray):void{
			if(current!=null)
				current.stop();
			
			current=new SoundPlayerSingle(mp3);
			current.play();
		}
		
		public static function stop():void{
			if(current!=null){
				current.stop();
				current=null;
			}
		}
		
		public function SoundPlayerSingle(data:ByteArray)
		{
			super(data);
		}
		
		override protected function onSoundComplete(event:Event):void{
			super.onSoundComplete(event);
			current=null;
		}
	}
}