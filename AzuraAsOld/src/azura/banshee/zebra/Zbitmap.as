package azura.banshee.zebra
{
	import azura.banshee.zebra.i.ZebraI;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class Zbitmap implements ZebraI
	{
//		public var mc5:String;
		
		public var bitmapData:BitmapData;
		
//		public function get width():int
//		{
//			return bitmapData.width;
//		}
//		
//		public function get height():int
//		{
//			return bitmapData.height;
//		}
		
		public function get boundingBox():Rectangle{
			return new Rectangle(bitmapData.width/2,bitmapData.height/2,bitmapData.width,bitmapData.height);
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
//			mc5=zb.readUTF();
		}
		
		public function toBytes():ZintBuffer
		{
			throw new Error();
//			var zb:ZintBuffer=new ZintBuffer();
//			zb.writeUTF(mc5);
//			return zb;
		}
		
		public function getMe5List():Vector.<String>
		{
			throw new Error();
//			var result:Vector.<String>=new Vector.<String>();
//			result.push(mc5);
//			return result;
		}
	}
}