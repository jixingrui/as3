package azura.banshee.mass.sdk
{
	public class MassCoder
	{		
		public var from:String;
		public var target:String;
		public var note:String;
				
		public function toString():String{
			return "[coder]"+note+"<from>"+from+
				"<target>"+target;
		}
	}
}