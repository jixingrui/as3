package azura.expresso.field {
	import azura.expresso.bean.Bean;
	import azura.expresso.bean.BeanInt;
	
	public class FieldInt extends FieldA {
		
		public function FieldInt(idx:int) {
			super(idx);
		}
				
		override public function newBean():Bean {
			return new BeanInt();
		}
		
	}
}