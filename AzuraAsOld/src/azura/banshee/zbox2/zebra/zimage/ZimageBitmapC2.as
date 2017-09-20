package azura.banshee.zbox2.zebra.zimage
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.branch.Zbitmap2;

	public class ZimageBitmapC2 extends Zbox2Container implements Zbox2ControllerI
	{
		public var data:Zbitmap2;
		
		public function ZimageBitmapC2(parent:Zbox2)
		{
			super(parent,true);
		}
		
		public function feed(data:Zbitmap2):void{
			this.data=data;
			zbox.load(data,0);
		}
		
	}
}