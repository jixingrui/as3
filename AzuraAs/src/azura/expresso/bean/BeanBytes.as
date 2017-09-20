package azura.expresso.bean {
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	
	public class BeanBytes extends BeanDispatcher implements Bean {
		private var value:ByteArray;
		
		public function readFrom(source:ZintBuffer):void {
			value = source.readBytesZ();
		}
		
		
		public function writeTo(dest:ZintBuffer):void {
			dest.writeBytesZ(value);
		}
		
		
		override public function eat(pray:Bean):void {
			value = pray.asBytes();
		}
		
		
		public function asInt():int {
			throw new IllegalOperationError();
		}
		
		
		public function asString():String {
			throw new IllegalOperationError();
		}
		
		
		public function asBytes():ZintBuffer {
			if(!(value is ZintBuffer))
				value= new ZintBuffer(value);
			
			return value as ZintBuffer;			
		}
		
		
		public function asDouble():Number {
			throw new IllegalOperationError();
		}
		
		
		public function asDatum():Datum {
			throw new IllegalOperationError();
		}
		
		
		public function asBeanList():BeanList {
			throw new IllegalOperationError();
		}
		
		
		public function setInt(value:int):void {
			throw new IllegalOperationError();
		}
		
		
		public function setString(string:String):void {
			throw new IllegalOperationError();
		}
		
		
		public function asBoolean():Boolean {
			throw new IllegalOperationError();
		}
		
		
		public function setBoolean(value:Boolean):void {
			throw new IllegalOperationError();
		}
		
		
		public function setBytes(value:ByteArray):void {
			this.value = value;
		}
		
		
		public function setDouble(value:Number):void {
			throw new IllegalOperationError();
		}
		
		
		public function setDatum(value:Datum):void {
			throw new IllegalOperationError();
		}
		
		
	}
}