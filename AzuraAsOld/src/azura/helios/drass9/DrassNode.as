package azura.helios.drass9
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;

	[Bindable]
	public class DrassNode implements BytesI
	{
		public var name:String;
		public var numChildren:int;
		public var node:Node;
		
		public function get data():ZintBuffer{
			if(node.data==null)
				return null;
			else
				return node.data.clone();
		}
		
		public function set data(value:ZintBuffer):void{
			node.data=value;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			name=zb.readUTF();
			numChildren=zb.readZint();
			node=new Node();
			node.data=zb.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTF(name);
			zb.writeZint(numChildren);
			zb.writeBytesZ(node.data);
			return zb;
		}
		
		public function clear():void{
			
		}
	}
}