package azura.banshee.mass.layer
{
	import azura.banshee.zbox2.Zspace2;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class ScreenDrag implements GdragI
	{
		public var space:Zspace2;
		
		private var xDown:Number;
		private var yDown:Number;
		public function dragStart():Boolean
		{
			xDown=-space.viewX;
			yDown=-space.viewY;
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			space.look(xDown+dx,yDown+dy);
			return false;
		}
		
		public function dragEnd():Boolean
		{
			return false;
		}
		
		public function get touchBox():TouchBox
		{
			return null;
		}
		
		public function set touchBox(box:TouchBox):void
		{
		}
	}
}