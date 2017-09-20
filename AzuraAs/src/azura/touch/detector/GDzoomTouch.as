package azura.touch.detector
{
	import flash.geom.Point;

	public class GDzoomTouch
	{
		public var id:int;
		public var start:Point=new Point();
		public var position:Point=new Point();
		public function clear():void{
			id=0;
			start=new Point();
			position=new Point();
		}
	}
}