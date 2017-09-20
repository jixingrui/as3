package azura.expresso.field {
	import azura.expresso.Clazz;
	import azura.expresso.bean.Bean;
	
	import flash.errors.IllegalOperationError;
	
	public class FieldA {
		public var idxBean:int;
		
		public function FieldA(idxBean:int) {
			this.idxBean = idxBean;
		}
		
		public function newBean():Bean{
			throw new IllegalOperationError();
		}
	}
}