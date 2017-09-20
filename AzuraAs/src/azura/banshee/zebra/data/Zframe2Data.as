package azura.banshee.zebra.data
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Zframe2Data implements BytesI
	{
		public var blank_key_delta:int=0;
		/**
		 * Let the logical position(point) be the origin. The anchor is the image
		 * center on the axis;
		 */
		public var anchor:Point=new Point();
		public var idxSheet:int;
		public var rectOnSheet:Rectangle=new Rectangle();
		
		/**
		 * The bounding box of the image positioned relative to the logical position of the frame(item). 
		 * 
		 */
		public function get boundingBox():Rectangle
		{
			var bb:Rectangle=new Rectangle();
			bb.x=-rectOnSheet.width/2-anchor.x;
			bb.y=-rectOnSheet.height/2-anchor.y;
			bb.width=rectOnSheet.width;
			bb.height=rectOnSheet.height;
			return bb;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			blank_key_delta=zb.readZint();
			if(blank_key_delta!=0){
				idxSheet=zb.readZint();
				rectOnSheet.x=zb.readZint();
				rectOnSheet.y=zb.readZint();
				rectOnSheet.width=zb.readZint();
				rectOnSheet.height=zb.readZint();
				anchor.x=zb.readDouble();
				anchor.y=zb.readDouble();
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(blank_key_delta);
			if(blank_key_delta!=0){
				zb.writeZint(idxSheet);
				zb.writeZint(rectOnSheet.x);
				zb.writeZint(rectOnSheet.y);
				zb.writeZint(rectOnSheet.width);
				zb.writeZint(rectOnSheet.height);
				zb.writeDouble(anchor.x);
				zb.writeDouble(anchor.y);
			}
			return zb;
		}
	}
}