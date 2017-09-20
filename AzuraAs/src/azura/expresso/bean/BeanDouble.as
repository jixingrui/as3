package azura.expresso.bean {
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	
	public class BeanDouble extends BeanDispatcher implements Bean {
		private var value:Number;
		
		
		public function readFrom(source:azura.common.collections.ZintBuffer):void {
			value=source.readDouble();
		}
		
		
		public function writeTo(dest:ZintBuffer):void {
			dest.writeDouble(value);
		}
		
		
		override public function eat(pray:Bean):void {
			value=pray.asDouble();
		}
		
		
		public function asInt():int {
			throw new IllegalOperationError();
		}
		
		
		public function asString():String {
			throw new IllegalOperationError();
		}
		
		
		public function asBoolean():Boolean {
			throw new IllegalOperationError();
		}
		
		
		public function asBytes():ZintBuffer {
			throw new IllegalOperationError();
		}
		
		
		public function asDouble():Number {
			return value;
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
		
		
		public function setString(value:String):void {
			throw new IllegalOperationError();
		}
		
		
		public function setBoolean(value:Boolean):void {
			throw new IllegalOperationError();
		}
		
		
		public function setBytes(value:ByteArray):void {
			throw new IllegalOperationError();
		}
		
		
		public function setDouble(value:Number):void {
			this.value=value;
		}
		
		
		public function setDatum(value:Datum):void {
			throw new IllegalOperationError();
		}
		
	}
}