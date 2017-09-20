package azura.expresso.field {
	import azura.expresso.NameSpace;
	import azura.expresso.bean.Bean;
	import azura.expresso.bean.BeanDatum;
	
	public class FieldDatum extends FieldA {
		private var type:int;
		private var ns:NameSpace;
		
		public function FieldDatum(idx:int, ns:NameSpace, type:int) {
			super(idx);
			this.ns=ns;
			this.type = type;
		}
				
		override public function newBean():Bean {
			return new BeanDatum(type,ns.newDatum(type));
		}
		
	}
}