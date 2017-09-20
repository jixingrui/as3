package azura.expresso.field {
	import azura.expresso.bean.Bean;
	import azura.expresso.bean.BeanString;
	
	public class FieldString extends FieldA {
		
		public function FieldString(idx:int) {
			super(idx);
		}
				
		override public function newBean():Bean {
			return new BeanString();
		}
		
	}
}