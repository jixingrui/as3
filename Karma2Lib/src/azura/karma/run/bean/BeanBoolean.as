package azura.karma.run.bean {
	import azura.common.collections.ZintBuffer;
	import azura.karma.run.Karma;
	
	public class BeanBoolean implements BeanI {
		private var value:Boolean;
		
		
		public function readFrom(source:ZintBuffer):void {
			value = source.readBoolean();
		}
		
		
		public function writeTo(dest:ZintBuffer):void {
			dest.writeBoolean(value);
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
			return value;
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
			throw new Error();
		}
		
		
		public function setString(value:String):void {
			throw new Error();
		}
		
		
		public function setBoolean(value:Boolean):void {
			this.value = value;
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