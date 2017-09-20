package azura.fractale.stream
{
	import flash.media.Microphone;
	import flash.media.MicrophoneEnhancedMode;
	import flash.media.MicrophoneEnhancedOptions;
	import flash.media.SoundCodec;

	public class Mic
	{
		public static function getMicrophone():Microphone
		{
			var mic:Microphone=Microphone.getMicrophone();
			
			mic.setLoopBack(false);
			mic.codec=SoundCodec.SPEEX;
//			mic.setSilenceLevel(6);
//			mic.encodeQuality=3;
			return mic;
		}
	}
}