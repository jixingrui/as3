package azura.mouse
{
	import flash.geom.Point;

	public class TouchHolder extends Point
	{
		public var id:int;
		public var position:Point=new Point();
		public function clear():void{
			id=0;
			position=new Point();
		}
	}
}