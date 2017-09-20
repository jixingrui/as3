package azura.karma.run.bean {
	
	import azura.common.collections.ZintBuffer;
	import azura.karma.def.KarmaFieldV;
	import azura.karma.def.KarmaSpace;
	import azura.karma.run.Karma;
	
	public class BeanList implements BeanI {
		private var space:KarmaSpace;
		private var list:KarmaList;
		
		public function BeanList(field:KarmaFieldV) {
			this.space=field.space;
			this.list=new KarmaList(field.fork);
		}
		
		public function asList():KarmaList{
			return list;
		}
		
		public function readFrom(reader:ZintBuffer):void {
			list.clear();
			var size:int = reader.readZint();
			for (var i:int = 0 ; i < size ; i++) {
				var one:Karma = new Karma(space);
				one.fromBytes(reader.readBytesZ());
				list.push(one);
			}
		}
		
		
		public function writeTo(writer:ZintBuffer):void {
			writer.writeZint(list.getList().length);
			for each (var one:Karma in list.getList()) {
				writer.writeBytesZ(one.toBytes());
			}
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
		
		
		public function asKarma():Karma {
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
		
		
		public function setKarma(value:Karma):void {
			throw new Error();
		}
	}
	
	
}