package azura.expresso.bean
{
	public class BeanDispatcher
	{
		protected var ret_newBean_oldBean:Function;
		public function addEventListener(ret_newBean_oldBean:Function):void
		{
			this.ret_newBean_oldBean=ret_newBean_oldBean;
		}
		
		public function change(newValue:Bean):void{
			if (ret_newBean_oldBean != null) {
				ret_newBean_oldBean.call(null,newValue,this);
			}
			eat(newValue);
		}
		
		public function eat(newValue:Bean):void{
			throw new Error("BeanDispatcher.eat: plz override");
		}
	}
}