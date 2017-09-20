package azura.banshee.mass.layer
{
	import azura.banshee.zbox2.Zspace2;
	import azura.touch.gesture.GdoubleI;
	
	public class ScreenBack implements GdoubleI
	{
		public var space:Zspace2;
		
		public function doubleClick():Boolean
		{
			space.look(0,0);
			return false;
		}
	}
}