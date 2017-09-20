package azura.banshee.mass.touch
{
	import azura.touch.gesture.GhoverI;
	import azura.touch.TouchBox;
	
	public class HoverUser implements GhoverI
	{
		public function HoverUser()
		{
		}
		
		public function hover():Boolean
		{
			trace("over",this);
			return false;
		}
		
		public function out():Boolean
		{
			trace("out",this);
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