package azura.avalon.mouse
{
	public class MouseDummy implements MouseTargetI
	{
		public function MouseDummy()
		{
		}
		
		public function get priority():int
		{
			return int.MIN_VALUE;
		}
		
		public function get active():Boolean{
			return false;
		}
	}
}