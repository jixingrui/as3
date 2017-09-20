package azura.banshee.zbox2.zebra.zimage
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.branch.ZimageSmall2;
	
	public class ZimageSmallC2 extends Zbox2Container implements Zbox2ControllerI
	{
		private var data:ZimageSmall2;
		
		public function ZimageSmallC2(parent:Zbox2)
		{
			super(parent,true);
		}
		
		public function feed(data:ZimageSmall2):void{
			this.data=data;
			doLoad();
		}
		
		override public function notifyChangeScale():void{
			if(zbox.loadingZup!=targetZup)
				doLoad();
		}
		
		private function doLoad():void{
			var zUp:int=targetZup;
//			trace("load zUp",zUp,this);
			zbox.load(data.line.getFrame(zUp,0),zUp);
		}
		
		private function get targetZup():int{
			return Math.min(zbox.zUpGlobal,data.line.zCount-1);
		}
		
	}
}