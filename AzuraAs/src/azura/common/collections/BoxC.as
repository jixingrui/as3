package azura.common.collections
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class BoxC
	{
		public var pos:Point=new Point();
//		public var lbb:Rectangle=new Rectangle();
		public var bb:RectC=new RectC();
		
		public function toRectangle():Rectangle{
			var rect:Rectangle=new Rectangle();
			rect.width=bb.width;
			rect.height=bb.height;
			rect.x=pos.x+bb.left;
			rect.y=pos.y+bb.top;
			return rect;
		}
		
		public function toRectC():RectC{
			var rc:RectC=new RectC();
			rc.width=bb.width;
			rc.height=bb.height;
			rc.xc=pos.x+bb.xc;
			rc.yc=pos.y+bb.yc;
			return rc;
		}
		
		public function eat(pray:BoxC):void{
			pos.x=pray.pos.x;
			pos.y=pray.pos.y;
			bb.xc=pray.bb.xc;
			bb.yc=pray.bb.yc;
			bb.width=pray.bb.width;
			bb.height=pray.bb.height;
		}
	}
}