package azura.common.collections
{
	
	import flash.geom.Rectangle;

	public class RectC implements ZintCodecI
	{
		public var xc:Number=0;
		public var yc:Number=0;
		public var width:Number=0;
		public var height:Number=0;
		
		public function readFrom(reader:ZintBuffer):void
		{
			xc=reader.readZint();
			yc=reader.readZint();
			width=reader.readZint();
			height=reader.readZint();
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			writer.writeZint(xc);
			writer.writeZint(yc);
			writer.writeZint(width);
			writer.writeZint(height);
		}
		
		public function toRectangle():Rectangle{
			var rect:Rectangle=new Rectangle();
			rect.width=this.width;
			rect.height=this.height;
			rect.x=xc-width/2;
			rect.y=yc-height/2;
			return rect;
		}
		
		public function toString():String{
			return "("+int(xc)+","+int(yc)+","+int(width)+","+int(height)+")";
		}
		
		public function clone():RectC{
			var c:RectC=new RectC();
			c.xc=this.xc;
			c.yc=this.yc;
			c.width=this.width;
			c.height=this.height;
			return c;
		}
		
		public function get left():Number{
			return xc-width/2;
		}
		
		public function set left(value:Number):void{
			var rightRec:Number=right;
			xc=(value+rightRec)/2;
			width=rightRec-value;
		}
		
		public function get right():Number{
			return xc+width/2;
		}
		
		public function set right(value:Number):void{
			var leftRec:Number=left;
			xc=(value+leftRec)/2;
			width=value - leftRec;
		}
		
		public function get top():Number{
			return yc-height/2;
		}
		
		public function set top(value:Number):void{
			var bottomRec:Number=bottom;
			yc=(value+bottomRec)/2;
			height=bottomRec-value;
		}

		public function get bottom():Number{
			return yc+height/2;
		}
		
		public function set bottom(value:Number):void{
			var topRec:Number=top;
			yc=(value+topRec)/2;
			height=value-topRec;
		}
	}
}