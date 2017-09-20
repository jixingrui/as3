package azura.expresso.bean {
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	public class BeanDatum extends BeanDispatcher implements Bean {
		private var type:int;
		private var value:Datum;
		
		public function BeanDatum(type:int,value:Datum) {
			this.type = type;
			this.value=value;
		}

		
		 public function readFrom(source:ZintBuffer):void {
			value.readFrom(source);
		}
		
		
		 public function writeTo(dest:ZintBuffer):void {
			value.writeTo(dest);
		}
		
		
		 override  public function eat(pray:Bean):void {
			value = pray.asDatum();
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
			throw new IllegalOperationError();
		}
		
		
		 public function asDatum():Datum {
			return value;
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
			throw new IllegalOperationError();
		}
		
		
		 public function setDatum(value:Datum):void {
			this.value = value;
		}
		
		
	}
}