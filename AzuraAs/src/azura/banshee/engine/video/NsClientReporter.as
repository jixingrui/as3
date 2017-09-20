package azura.banshee.engine.video
{

	public class NsClientReporter
	{
		public var host:VideoStarling;
		
		public function NsClientReporter(host:VideoStarling){
			this.host=host;
		}
		
		public function onPlayStatus(info:Object):void{
		}		
		public function onXMPData(info:Object):void{
		}
		public function onCuePoint(info:Object):void { 
		} 
		
		public function onMetaData(info:Object):void { 
			host.onMetaData(info["width"],info["height"],info["duration"]);
//			if(info["width"]!=null)
//				host.width=info["width"];			
//			if(info["height"]!=null)
//				host.height=info["height"];			
//			if(info["duration"]!=null)
//				host.duration=info["duration"];
//			trace("meta data: w=",host.width,"h=",host.height,this);
		} 
	}
}