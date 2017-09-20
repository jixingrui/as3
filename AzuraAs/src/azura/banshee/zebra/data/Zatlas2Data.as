package azura.banshee.zebra.data
{
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.banshee.zebra.data.wrap.Zsheet2;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4PackI;

	public class Zatlas2Data implements Gal4PackI, BytesI
	{
		public var sheetList:Vector.<Zsheet2>=new Vector.<Zsheet2>();
		public var frameList:Vector.<Zframe2>=new Vector.<Zframe2>();
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var sheetCount:int=zb.readZint();
			for(var si:int=0;si<sheetCount;si++){
				var sheet:Zsheet2=new Zsheet2();
				sheet.fromBytes(zb.readBytesZ());
				sheetList.push(sheet);
			}
			var frameCount:int=zb.readZint();
			for(var fi:int=0;fi<frameCount;fi++){
				var frame:Zframe2=new Zframe2();
				frame.fromBytes(zb.readBytesZ());
				frameList.push(frame);
				frame.sheet=sheetList[frame.idxSheet];
				frame.idxInAtlas=fi;
//				frame.sheet.frameList.push(frame);
			}
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
		
		public function getMc5List(dest:Vector.<String>):void
		{
			for each(var sheet:Zsheet2 in sheetList){
				sheet.getMc5List(dest);
			}
		}
	}
}