package azura.expresso.field {
	import azura.expresso.bean.Bean;
	import azura.expresso.bean.BeanDouble;
	
	public class FieldDouble extends FieldA {
		
		public function FieldDouble(idx:int) {
			super(idx);
		}
				
		override public function newBean():Bean {
			return new BeanDouble();
		}
		
	}
}