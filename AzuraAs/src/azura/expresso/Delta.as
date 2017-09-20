package azura.expresso
{
	import azura.expresso.bean.Bean;
	
	import azura.common.collections.ZintBuffer;

	public class Delta
	{
		private var ns:NameSpace;
		private var clazz:Clazz;
		public var changeList:Vector.<Change>=new Vector.<Change>();
		
		public function Delta(ns:NameSpace,zb:ZintBuffer)
		{
			this.ns=ns;
			decode(zb);
		}
		
		private function decode(zb:ZintBuffer):void{
			var idClass:int = zb.readZint();
			clazz = ns.getClass(idClass);
			var size:int = zb.readZint();
			for (var i:int = 0; i < size; i++) {
				var idx:int = zb.readZint();
				var bean:Bean = clazz.fieldAll[idx].newBean();
				bean.readFrom(zb);
				changeList.push(new Change(idx, bean));
			}
		}
		
		public function apply(datum:Datum):void{
			for each(var c:Change in changeList) {
				datum.beanList[c.idx].change(c.bean);
			}
		}
	}
}
import azura.expresso.bean.Bean;

class Change{
	public var idx:int;
	public var bean:Bean;
	
	public function Change(idx:int,bean:Bean){
		this.idx=idx;
		this.bean=bean;
	}
}