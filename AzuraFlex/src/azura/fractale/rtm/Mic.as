package azura.fractale.rtm
{
	import flash.media.Microphone;
	import flash.media.MicrophoneEnhancedMode;
	import flash.media.MicrophoneEnhancedOptions;
	import flash.media.SoundCodec;
	
	public class Mic
	{
		private static var mic:Microphone;
		public static function getMic():Microphone{
			
			if(mic!=null){
				return mic;
			}
			
			mic=Microphone.getMicrophone();
			if(mic!=null){
				
				mic.codec=SoundCodec.SPEEX;		
				mic.setUseEchoSuppression(false);
				mic.setSilenceLevel(0);
				mic.framesPerPacket=8;
				mic.rate = 11;
				mic.gain=80;
				mic.encodeQuality=6;
				
			}
			
			return mic;
		}
	}
}