package azura.karma.editor.def {
	import azura.common.collections.ZintBuffer;
	import azura.karma.run.bean.BeanTypeE;
	
	public class KarmaFieldExt extends KarmaField {
//		public var name:String;
		
		public var fork:Vector.<KarmaTooth>;
		
//		public var idx:int;
		
		public override function readFrom(reader:ZintBuffer):void {
			super.readFrom(reader);
//			name = reader.readUTFZ();
			if ((type == BeanTypeE.KARMA) || (type == BeanTypeE.LIST)) {
				var size:int = reader.readZint();
				fork=new Vector.<KarmaTooth>();
				for (var i:int = 0 ; i < size ; i++) {
					var tooth:KarmaTooth = new KarmaTooth();
					tooth.readFrom(reader);
					fork.push(tooth);
				}
			} 
		}
		
		public function fromBytesSuper(bytes:ZintBuffer):void {
			var reader:ZintBuffer = new ZintBuffer(bytes);
			super.readFrom(reader);
		}
		
		public function toBytesSuper():ZintBuffer {
			var writer:ZintBuffer = new ZintBuffer();
			super.writeTo(writer);
			return writer;
		}
		
		public function toBytes():ZintBuffer {
			var writer:ZintBuffer = new ZintBuffer();
			writeTo(writer);
			return writer;
		}
		
		
		public override function writeTo(writer:ZintBuffer):void {
			super.writeTo(writer);
			writer.writeUTFZ(name);
			if ((type == BeanTypeE.KARMA) || (type == BeanTypeE.LIST)) {
				writer.writeZint(fork.length);
				for each (var tooth:KarmaTooth in fork) {
					tooth.writeTo(writer);
				}
			} 
		}
	}
	
	
}