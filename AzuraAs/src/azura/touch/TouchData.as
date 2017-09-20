package azura.touch
{
	public class TouchData
	{
		public var id:int;
		public var x:Number;
		public var y:Number;
		
		public function TouchData(){
			clear();
		}
		
		public function clear():void{
			id=-1;
			x=0;
			y=0;
		}
	}
}