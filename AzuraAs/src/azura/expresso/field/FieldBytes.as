package azura.expresso.field {
	import azura.expresso.bean.Bean;
	import azura.expresso.bean.BeanBytes;
	
	public class FieldBytes extends FieldA {
		
		public function FieldBytes(idx:int) {
			super(idx);
		}
				
		override public function newBean():Bean {
			return new BeanBytes();
		}
		
	}
}