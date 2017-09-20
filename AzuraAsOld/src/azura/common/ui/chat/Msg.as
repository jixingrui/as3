package azura.common.ui.chat
{
	[Bindable]
	public class Msg
	{
		public var name:String;
		public var text_voice:Boolean;
		public var text:String;
		public var time:int;
		public var mc5:String;
		
		public function Msg(text_voice:Boolean){
			this.text_voice=text_voice;
		}
	}
}