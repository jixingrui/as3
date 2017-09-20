package azura.banshee.zbox2.zebra
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	
	public class ZblankC2 extends Zbox2Container implements Zbox2ControllerI
	{
		public function ZblankC2(parent:Zbox2)
		{
			super(parent, false);
		}
		
		public function clear():void{
			zbox.clear();
		}
	}
}