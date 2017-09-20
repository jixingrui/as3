package azura.banshee.engine.video
{
	public class NsClientSilent
	{
		public function onPlayStatus(info:Object):void{
		}		
		public function onXMPData(info:Object):void{
		}
		public function onMetaData(info:Object):void { 
//			if(info["width"]!=null && info["height"]!=null){
//				trace("width=",info["width"],"height=",info["height"],this);
//			}
		} 
		public function onCuePoint(info:Object):void { 
		} 
	}
}