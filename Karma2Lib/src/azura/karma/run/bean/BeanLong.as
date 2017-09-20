package azura.karma.run.bean {
	import azura.common.collections.ZintBuffer;
	import azura.karma.run.Karma;
	
	public class BeanLong implements BeanI {
		private var value:Number;
		
		public function readFrom(source:ZintBuffer):void {
			value = source.readLongZ();
		}
		
		public function writeTo(dest:ZintBuffer):void {
			dest.writeLongZ(value);
		}
		
		public function asInt():int {
			throw new Error();
		}
		
		public function asLong():Number{
			return value;
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
		
		public function asList():KarmaList{
			throw new Error();
		}
		
		public function setInt(value:int):void {
			this.value = value;
		}
		
		public function setLong(value:Number):void{
			this.value=value;
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