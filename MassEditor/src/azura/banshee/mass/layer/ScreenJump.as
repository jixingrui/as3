package azura.banshee.mass.layer
{
	import azura.banshee.zbox2.Zspace2;
	import azura.touch.gesture.GsingleI;
	
	public class ScreenJump implements GsingleI
	{
		public var space:Zspace2;
		
		public function singleClick(x:Number, y:Number):Boolean
		{
			space.look(x,y);
			return false;
		}
	}
}