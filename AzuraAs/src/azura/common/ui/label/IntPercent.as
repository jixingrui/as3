package azura.common.ui.label
{
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;

	public class IntPercent implements ZintCodecI
	{
		public var int_percent:Boolean;
		public var value:int;
		
		public function IntPercent()
		{
		}
		
		public function translate(from:Number):Number{
			if(int_percent)
				return value;
			else
				return from*value/100;
		}

		public function get string():String
		{
			if(int_percent)
				return value+'';
			else
				return value+'%';
		}

		public function set string(s:String):void
		{
			var tail:String=s.substring(s.length-1);
			int_percent=(tail!='%');
			value=parseInt(s);
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			int_percent=reader.readBoolean();
			value=reader.readZint();
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			writer.writeBoolean(int_percent);
			writer.writeZint(value);
		}
	}
}