package azura.expresso.bean {
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	
	public class BeanInt extends BeanDispatcher implements Bean {
		private var value:int;
		
		
		public function readFrom(source:ZintBuffer):void {
			value=source.readZint();
		}
		
		
		public function writeTo(dest:ZintBuffer):void {
			dest.writeZint(value);
		}
		
		
		override public function eat(pray:Bean):void {
			value=pray.asInt();
		}
		
		
		public function asInt():int {
			return value;
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
			throw new IllegalOperationError();
		}
		
		
		public function asDatum():Datum {
			throw new IllegalOperationError();
		}
		
		
		public function asBeanList():BeanList {
			throw new IllegalOperationError();
		}
		
		
		public function setInt(value:int):void {
			this.value=value;
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
			throw new IllegalOperationError();
		}
		
		
		public function setDatum(value:Datum):void {
			throw new IllegalOperationError();
		}
		
	}
}