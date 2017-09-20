package azura.banshee.zbox2.zebra.zmatrix
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.branch.Zline2;
	import azura.common.algorithm.mover.Cycler2;
	import azura.common.algorithm.mover.CycleUserI;
	
	public class ZhlineC2 extends Zbox2Container implements Zbox2ControllerI, CycleUserI
	{
		public var cycler:Cycler2=new Cycler2();
		private var line:Zline2;
		
		public function ZhlineC2(parent:Zbox2)
		{
			super(parent,true);
		}
		
		public function feed(line:Zline2,fps:int):void{
			this.line=line as Zline2;
			cycler.fps=fps;
			cycler.register(this,this.line.frameCount);
		}
		
		public function showFrame(frame:int=-1):void
		{
//			trace("show frame",frame,this);
			cycler.pause();
			doLoad();
		}
		
		public function get frameCount():int{
			return line.frameCount;
		}
		
		public function cycleEnd():void{
			
		}
		
		override public function notifyLoadingFinish():void
		{
			cycler.resume();
		}
		
		private function get targetZup():int{
			return Math.min(zbox.zUpGlobal,line.zCount-1);
		}
		
		private function doLoad():void{
			var loadingZup:int=targetZup;
//			trace("load zup",loadingZup,this);
			zbox.load(line.getFrame(loadingZup,cycler.currentFrame),loadingZup);
		}
		
		override public function notifyDispose():void{
			cycler.unregister();
		}
		
//		override public function clear():void{
//			cycler.unregister();
//		}
		
	}
}