package azura.common.graphics
{
	import flash.geom.Point;
	
	public class Point3 extends Point
	{
		public var z:Number;
		
		public function Point3(x:Number=0, y:Number=0, z:Number=0)
		{
			super(x, y);
			this.z=z;
		}
		
		override public function toString():String{
			return "(x="+x+", y="+y+", z="+z+")";
		}
	}
}