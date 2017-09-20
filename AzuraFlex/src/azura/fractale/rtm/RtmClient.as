package azura.fractale.rtm
{
	import org.osflash.signals.Signal;
	
	public class RtmClient
	{
		private var rtm:Rtm;
		public function RtmClient(rtm:Rtm){
			this.rtm=rtm;
		}
		
		public function askMic(value:int):void{
			rtm.streamAskMic(value);
		}
		
		public function iHearYou():void{
			rtm.streamSaysIHearYou();
		}
		
		public function giveMic():void{
			rtm.streamGiveMic();
		}
		
		public function returnMic():void{
			rtm.streamReturnMic();
		}
		
		public function retry():void{
			rtm.streamRetry();
		}

	}
}