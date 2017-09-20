package azura.karma.run.bean {
	
	import azura.common.collections.ZintBuffer;
	import azura.karma.def.KarmaFieldV;
	import azura.karma.def.KarmaSpace;
	import azura.karma.run.Karma;
	
	
	public class BeanKarma implements BeanI {
		private var space:KarmaSpace;
		private var fork:Vector.<int>;
		private var value:Karma;
		
		public function BeanKarma(field:KarmaFieldV) {
			this.space=field.space;
			this.fork=field.fork;
		}
		
		public function readFrom(reader:ZintBuffer):void {
			var valueIsNull:Boolean=reader.readBoolean();
			if(valueIsNull==false){
				value=new Karma(space);
				value.fromBytes(reader.readBytesZ());
			}
		}
		
		public function writeTo(writer:ZintBuffer):void {
			writer.writeBoolean(value==null);
			if(value!=null)
				writer.writeBytesZ(value.toBytes());
			else
				trace("karma is null",this);
		}
		
		
		public function asKarma():Karma {
			return value;
		}
		
		public function setKarma(value:Karma):void {
			if(value==null){
				//null is supported
				this.value=null;
			}else if (fork.indexOf(value.type)>=0)
				this.value = value;
			else
				throw new Error("karma type not match");
		}
		
		
		public function asInt():int {
			throw new Error();
		}
		
		public function asLong():Number{
			throw new Error();
		}
		
		public function setLong(value:Number):void{
			throw new Error();
		}
		
		public function asString():String {
			throw new Error();
		}
		
		
		public function asBoolean():Boolean {
			throw new Error();
		}
		
		
		public function asBytes():ZintBuffer {
			throw new Error();
		}
		
		
		public function asDouble():Number {
			throw new Error();
		}
		
		
		public function asList():KarmaList{
			throw new Error();
		}
		
		public function setInt(value:int):void {
			throw new Error();
		}
		
		
		public function setString(value:String):void {
			throw new Error();
		}
		
		
		public function setBoolean(value:Boolean):void {
			throw new Error();
		}
		
		
		public function setBytes(value:ZintBuffer):void {
			throw new Error();
		}
		
		
		public function setDouble(value:Number):void {
			throw new Error();
		}
		
		
	}
	
	
}