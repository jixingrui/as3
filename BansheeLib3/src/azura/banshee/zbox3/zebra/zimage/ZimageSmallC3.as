package azura.banshee.zbox3.zebra.zimage
{
	import azura.banshee.zbox3.engine.FrameCarrier;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zebra.branch.ZimageSmall2;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.common.algorithm.FastMath;
	
	public class ZimageSmallC3 extends Zbox3Container
	{
		private var data:ZimageSmall2;
		private var oldZup:int=0;
		
		public function ZimageSmallC3(parent:Zbox3)
		{
			super(parent);
		}
		
		public function feed(data:ZimageSmall2):void{
			this.data=data;
			doLoad();
		}
		
		private function doLoad():void{
			oldZup=zUp;
			var res:Zframe2=data.line.getFrame(oldZup,0);
			var link:FrameCarrier=new FrameCarrier();
			link.frame=res;
			zbox.replica.smoothing=true;
			zbox.load(link);
		}
		
		override public function notifyChangeScale():void{
			var newZup:int=zUp;
			if(newZup==oldZup){
				return;
			}
			doLoad();
		}
		
		private function get zUp():int{
			var target:int= FastMath.log2(Math.round(1/(zbox.scaleGlobal*zbox.space.scaleView)));
			return Math.min(target,data.line.zCount-1);
		}
		
		override public function notifyLoadingFinish():void{
			zbox.scaleFix=FastMath.pow2x(oldZup);
		}
		
	}
}