package azura.banshee.zebra.atlas
{
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.GsI;
	
	public class Zatlas implements GsI
	{
		public var frameList:Vector.<Zframe>=new Vector.<Zframe>();
		public var sheetList:Vector.<Zsheet>=new Vector.<Zsheet>();
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var sheetCount:int=zb.readZint();
			for(var si:int=0;si<sheetCount;si++){
				var sheet:Zsheet=new Zsheet();
				sheet.fromBytes(zb.readBytesZ());
				sheetList.push(sheet);
			}
			var frameCount:int=zb.readZint();
			for(var fi:int=0;fi<frameCount;fi++){
				var frame:Zframe=new Zframe();
				frame.fromBytes(zb.readBytesZ());
				frameList.push(frame);
			}
//			trace("sheet=",sheetCount,"frame=",frameCount,this);
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(sheetList.length);
			for(var j:int=0;j<sheetList.length;j++){
				zb.writeBytesZ(sheetList[j].toBytes());
			}
			zb.writeZint(frameList.length);
			for(var i:int=0;i<frameList.length;i++){
				zb.writeBytesZ(frameList[i].toBytes());
			}
			return zb;
		}
		
		public function getMe5List():Vector.<String>
		{
			var mc5List:Vector.<String>=new Vector.<String>();
			for each(var s:Zsheet in sheetList){
				var subList:Vector.<String>=s.getMe5List();
				for each(var mc5:String in subList){
					mc5List.push(mc5);
				}
			}
			return mc5List;
		}
		
	}
}