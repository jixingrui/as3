package azura.expresso.field {
	import azura.expresso.bean.Bean;
	import azura.expresso.bean.BeanListShell;
	
	public class FieldList extends FieldA {
		
		private var type:FieldA;
		
		public function FieldList(idx:int, type:FieldA) {
			super(idx);
			this.type = type;
		}
				
		override public function newBean():Bean {
			return new BeanListShell(type);
		}
		
	}
}