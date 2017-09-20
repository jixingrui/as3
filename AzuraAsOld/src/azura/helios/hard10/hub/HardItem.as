package azura.helios.hard10.hub
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	[Bindable]
	public class HardItem implements BytesI
	{
		public var name:String;
		public var numChildren:int;
		private var data_:ZintBuffer;
		
		public function HardItem(zb:ZintBuffer=null){
			if(zb!=null)
				fromBytes(zb);
		}
		
		public function eat(pray:HardItem):void{
			this.name=pray.name;
			this.numChildren=pray.numChildren;
			this.data_=pray.data_;
		}
		
		public function get data():ZintBuffer{
			return data_;
//			if(data_==null)
//				return null;
//			else
//				return data_.clone();
		}
		
		public function set data(value:ZintBuffer):void{
			data_=value;
		}
		
		public function clone():HardItem{
			var c:HardItem=new HardItem();
			c.name=name;
			c.numChildren=numChildren;
			c.data_=data_;
			return c;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			name=zb.readUTFZ();
			numChildren=zb.readZint();
			data_=zb.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(name);
			zb.writeZint(numChildren);
			zb.writeBytesZ(data_);
			return zb;
		}
		
	}
}