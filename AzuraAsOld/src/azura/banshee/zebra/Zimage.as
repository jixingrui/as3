package azura.banshee.zebra
{
	import azura.banshee.zebra.i.ZebraI;
	import azura.banshee.zebra.atlas.Zatlas;
	import azura.banshee.zebra.zimage.ZimageLarge;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Rectangle;
	
	
	public class Zimage implements BytesI,ZebraI
	{		
		//data
		private var _boundingBox:Rectangle=new Rectangle();
		public var tinySheet:Zatlas;
		public var useLarge:Boolean;
		public var pyramid:ZimageLarge;
		
		public function get width():int
		{
			return boundingBox.width;
		}
		
		public function get height():int
		{
			return boundingBox.height;
		}
		
		public function get boundingBox():Rectangle
		{
			return _boundingBox;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			boundingBox.x=zb.readZint();
			boundingBox.y=zb.readZint();
			boundingBox.width=zb.readZint();
			boundingBox.height=zb.readZint();
			tinySheet=new Zatlas();
			tinySheet.fromBytes(zb.readBytesZ());
			useLarge=zb.readBoolean();
			if(useLarge){
				pyramid=new ZimageLarge();
				pyramid.fromBytes(zb.readBytesZ());
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(boundingBox.x);
			zb.writeZint(boundingBox.y);
			zb.writeZint(boundingBox.width);
			zb.writeZint(boundingBox.height);
			zb.writeBytesZ(tinySheet.toBytes());
			zb.writeBoolean(useLarge);
			if(useLarge)
				zb.writeBytesZ(pyramid.toBytes());
			
			return zb;
		}
		
		public function getMe5List():Vector.<String>
		{
			var mc5:String;
			var result:Vector.<String>=new Vector.<String>();
			for each(mc5 in tinySheet.getMe5List()){
				result.push(mc5);
			}
			if(useLarge){
				for each(mc5 in pyramid.getMe5List()){
					result.push(mc5);
				}
			}
			return result;
		}
		
	}
}