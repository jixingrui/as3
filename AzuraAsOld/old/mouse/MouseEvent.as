package azura.avalon.mouse
{
	public class MouseEvent
	{
		public var target:MouseTargetI;
		public var x:int;
		public var y:int;
		public var processed:Boolean;
		public var ended:Boolean;
		
		public function MouseEvent()
		{
		}
	}
}