package maze.control
{
	import azura.touch.gesture.GsingleI;
	
	public class CharClicker implements GsingleI
	{
		public function CharClicker()
		{
		}
		
		public function singleClick(x:Number, y:Number):Boolean
		{
			trace("click",x,y,this);
			return false;
		}
	}
}