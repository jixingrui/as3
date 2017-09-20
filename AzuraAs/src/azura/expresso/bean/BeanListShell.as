package azura.expresso.bean {
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.field.FieldA;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	
	public class BeanListShell extends BeanDispatcher implements Bean,BeanList{
		
		private var type:FieldA;
		private var list:Vector.<Bean>=new Vector.<Bean>();
		
		public function BeanListShell(type:FieldA) {
			this.type = type;
		}		
		
		public function addBean():Bean
		{
			var b:Bean=type.newBean();
			list.push(b);
			return b;
		}
		
		public function getList():Vector.<Bean>
		{
			return list;
		}
		
		public function readFrom(source:ZintBuffer):void {
			var size:int=source.readZint();
			list = new Vector.<Bean>();
			for (var i:int= 0; i < size; i++) {
				var item:Bean= type.newBean();
				item.readFrom(source);
				list.push(item);
			}
		}
		
		
		public function writeTo(dest:ZintBuffer):void {
			dest.writeZint(list.length);
			for each(var b:Bean in list) {
				b.writeTo(dest);
			}			
		}
		
		
		override public function eat(pray:Bean):void {
			list = pray.asBeanList().getList();
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
			throw new IllegalOperationError();
		}
		
		
		public function asBeanList():BeanList {
			return this as BeanList;
		}
		
		
		public function setInt(list:int):void {
			throw new IllegalOperationError();
		}
		
		
		public function setString(list:String):void {
			throw new IllegalOperationError();
		}
		
		
		public function setBoolean(list:Boolean):void {
			throw new IllegalOperationError();
		}
		
		
		public function setBytes(list:ByteArray):void {
			throw new IllegalOperationError();
		}
		
		
		public function setDouble(list:Number):void {
			throw new IllegalOperationError();
		}
		
		
		public function setDatum(list:Datum):void {
			throw new IllegalOperationError();
		}
		
	}
}