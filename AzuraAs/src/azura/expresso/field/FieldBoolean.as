package azura.expresso.field {
	import azura.expresso.bean.Bean;
	import azura.expresso.bean.BeanBoolean;
	
	public class FieldBoolean extends FieldA {
		
		public function FieldBoolean(idx:int) {
			super(idx);
		}
				
		override public function newBean():Bean {
			return new BeanBoolean();
		}
		
	}
}