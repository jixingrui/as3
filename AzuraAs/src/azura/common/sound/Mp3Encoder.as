package azura.common.sound
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import fr.kikko.lab.ShineMP3Encoder;
	
	import org.osflash.signals.Signal;

	public class Mp3Encoder
	{
		private static var mp3Encoder:ShineMP3Encoder;
		
		public static var onMp3:Signal=new Signal(ByteArray,int);
		
		private static var taskQue:Vector.<SoundClip>=new Vector.<SoundClip>();
		private static var current:SoundClip;
		
		public static function encode(data:ByteArray, ms:int):void{
			var sc:SoundClip=new SoundClip();
			sc.data=data;
			sc.milliseconds=ms;
			taskQue.push(sc);
			checkTask();
		}
		
		private static function checkTask():void{

			if(current!=null || taskQue.length==0)
				return;
			
			current=taskQue.shift();
			
			var wav:ByteArray = WaveEncoder.encode(current.data);
			
			wav.position=0;
			mp3Encoder = new ShineMP3Encoder(wav,64);
			mp3Encoder.addEventListener(Event.COMPLETE, mp3EncodeComplete);
			mp3Encoder.start();	
			
			function mp3EncodeComplete(e: Event) : void 
			{
				mp3Encoder.removeEventListener(Event.COMPLETE, mp3EncodeComplete);
				var mp3:ByteArray=new ByteArray();
				mp3.writeBytes(mp3Encoder.mp3Data);
				mp3.position=0;
				mp3Encoder=null;
				
				var result:SoundClip=current;
				result.data=mp3;
				current=null;
				
				onMp3.dispatch(result.data,result.milliseconds);
				checkTask();
			}	
		}
	}
}