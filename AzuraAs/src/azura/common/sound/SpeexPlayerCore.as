package azura.common.sound  
{
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	
	import org.osflash.signals.Signal;
	
	public class SpeexPlayerCore
	{
		private static var playbackSpeed:Number = 11025/44100;		
		
		{
			SoundMixer.useSpeakerphoneForVoice=true;
		}
		
		private var extracted:ByteArray= new ByteArray();		
		private var phase:Number;
		
		private var sound:Sound;
		private var channel:SoundChannel;
		
		private var data:ByteArray;
		
		protected var pausePosition:int=-1;
		
		public function SpeexPlayerCore(data:ByteArray)
		{
			this.data=data;
		}		
		
		protected function play():void
		{
			phase = 0;
			data.position=0;
			
			var _extractor:Sound = new Sound();
			_extractor.loadCompressedDataFromByteArray(data,data.length);
			_extractor.extract(extracted, int(_extractor.length * 44.1));
			
			extracted.position=0;
			
			sound=new Sound();
			channel=new SoundChannel();
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			
			channel=sound.play();
			if(channel!=null)
				channel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);			
		}
		
		protected function onSoundComplete(event:Event):void{
			stop();
		}
		
		protected function pause():Boolean{
			if(channel==null)
				return false;
			else{
				pausePosition=channel.position;
				channel.stop();
				return true;
			}
		}
		
		protected function resume():Boolean{
			if(pausePosition<0){
				return false;
			}else{
				channel=sound.play(pausePosition);
				pausePosition=0;
				return true;
			}
		}
		
		protected function stop():void{
			pausePosition=-1;
			channel.stop();
			channel.removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
			channel=null;
			sound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			sound=null;
		}
		
		private function onSampleData( event:SampleDataEvent ):void
		{			
			var outputLength:int = 0;
			while (outputLength < 8192) { 
				
				extracted.position = int(phase) * 8;// 4 bytes per float and two channels so the actual position in the ByteArray is a factor of 8 bigger than the phase
				
				if(extracted.bytesAvailable<8)
					break;
				
				// read out the left and right channels at this position
				// write the samples to our output buffer
				event.data.writeFloat(extracted.readFloat());
				event.data.writeFloat(extracted.readFloat());
				
				outputLength++;
				
				// advance the phase by the speed...
				phase += playbackSpeed;
			}
		}
	}
}
