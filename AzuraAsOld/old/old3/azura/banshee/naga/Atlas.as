package old.azura.banshee.naga
{
	import azura.gallerid.Gal_Memory;
	import azura.gallerid.Gal_PackOld;
	
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.Dictionary;
	
	public class Atlas
	{
		private var frameList:Vector.<Frame>=new Vector.<Frame>();
		public function Atlas(zb:ZintBuffer,priority:Boolean=false)
		{
			var frameCount:int=zb.readZint();
			for(var j:int=0;j<frameCount;j++){
				var frame:Frame=new Frame(zb.readBytes_());
				frame.idx=j;
				frameList.push(frame);
				
//				if(priority)
//					frame.loadTexture(null,false);
			}
		}
		
//		public function dispose():void{
//			for each(var f:FrameStarling in frameList){
//				f.dispose();
//			}
//		}
		
		public function getFrame(frameIdx:int):Frame{
			var frame:Frame=frameList[frameIdx];
			return frame;
		}
		
		public function get frameCount():int{
			return frameList.length;
		}
		
		public function extractMd5(gp:Gal_PackOld):void{
			for each (var f:Frame in frameList) {
				f.extractMd5(gp);
			}
		}
	}
}