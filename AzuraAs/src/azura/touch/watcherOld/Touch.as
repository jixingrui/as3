package azura.touch.watcherOld
{
	import flash.geom.Point;

	public class Touch
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