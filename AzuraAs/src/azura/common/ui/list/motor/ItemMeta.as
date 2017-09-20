package azura.common.ui.list.motor
{
	public class ItemMeta
	{
		public var item:ListMotorItemI;
		/**
		 * If I am boss. 
		 */
		public var gap:Number=0;
		public var sum:Number=0;
		public var d0:Number=0;
		public var xt:Number=0;
//		public var visible:Boolean=false;
		
		public function ItemMeta(item:ListMotorItemI)
		{
			this.item=item;
		}
	}
}