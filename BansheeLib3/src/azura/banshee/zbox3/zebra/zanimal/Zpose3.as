package azura.banshee.zbox3.zebra.zanimal
{
	import azura.common.collections.BytesI;
	import azura.common.collections.NameI;
	import azura.common.collections.NamedBytesI;
	import azura.common.collections.ZintBuffer;
	
	public class Zpose3 implements BytesI,NameI
	{
		private var name_:String;
		
		public function Zpose3(name:String=null){
			this.name=name;
		}
		
		[Bindable]
		public function get name():String
		{
			return name_;
		}
		
		public function set name(value:String):void
		{
			name_=value;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			name_=zb.readUTFZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(name_);
			return zb;
		}
		
		public function clear():void
		{
			name=null;
		}
	}
}