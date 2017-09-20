package azura.banshee.zebra.box
{
	import flash.geom.Rectangle;

	public class AbBoxLeaf extends AbBox
	{
		public function AbBoxLeaf(parent:AbBox)
		{
			super(parent);
		}
	
		public function set boundingBox(value:Rectangle):void{
			if(value==null)
				return;
			bbLocal.copyFrom(value);
			super.updateLeafBB();
		}
	}
}