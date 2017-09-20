package azura.common.graphics
{
	import flash.geom.Rectangle;
	
	public class RectangleCOld
	{
		private var rect:Rectangle;	
		private var _z:int;
		
		public function RectangleCOld(x:int=0, y:int=0, width:int=0, height:int=0)
		{
			rect=new Rectangle(x, y, width, height);
		}
		
		public function get z():int
		{
			return _z;
		}

		public function set z(value:int):void
		{
			_z = value;
		}

		public function get height():int
		{
			return rect.height;
		}

		public function set height(value:int):void
		{
			var yc:int=yCenter;
			rect.height = value;
			yCenter=yc;
		}

		public function get width():int
		{
			return rect.width;
		}

		public function set width(value:int):void
		{
			var xc:int=xCenter;
			rect.width=value;
			xCenter=xc;
		}

		public function get xCenter():int
		{
			return rect.x+rect.width/2;
		}
		
		public function set xCenter(value:int):void
		{
			var dx:int=value-xCenter;
			rect.x+=dx;
		}
		
		public function get yCenter():int
		{
			return rect.y+rect.height/2;
		}
		
		public function set yCenter(value:int):void
		{
			var dy:int=value-yCenter;
			rect.y+=dy;
		}
		
		public function get x():int{
			return rect.x;
		}
		
		public function set x(value:int):void{
			rect.x=value;
		}
		
		public function get y():int{
			return rect.y;
		}
		
		public function set y(value:int):void{
			rect.y=value;
		}
		
		public function get right():int{
			return rect.right;
		}
		
		public function get bottom():int{
			return rect.bottom;
		}
		
		public function intersection(toIntersect:RectangleCOld):RectangleCOld{
			var result:RectangleCOld=new RectangleCOld();
			result.rect=rect.intersection(toIntersect.rect);
			return result;
		}
		
		public function intersects(toIntersect:RectangleCOld):Boolean{
			return rect.intersects(toIntersect.rect);
		}
		
		public function union(toUnion:RectangleCOld):RectangleCOld{
			var result:RectangleCOld=new RectangleCOld();
			result.rect=rect.union(toUnion.rect);
			return result;
		}
		
		public function clone():RectangleCOld{
			var result:RectangleCOld=new RectangleCOld();
			result.rect=this.rect.clone();
			return result;
		}
	}
}