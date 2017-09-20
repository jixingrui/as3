package azura.banshee.zbox3.zebra.zmatrix
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.engine.FrameCarrier;
	import azura.banshee.zbox3.zebra.LoopControlI;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.branch.Zline2;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.mover.CycleUserI;
	import azura.common.algorithm.mover.Cycler3;
	
	public class ZhlineC3 extends Zbox3Container implements CycleUserI,LoopControlI
	{
		private var cycler:Cycler3;
		private var line:Zline2;
		private var oldZup:int=0;
		
		private var zebra:ZebraC3;
		
		public function ZhlineC3(parent:Zbox3,zebra:ZebraC3)
		{
			super(parent);
			this.zebra=zebra;
			cycler=new Cycler3(this);
		}
		
		public function get framePercent():Number
		{
			return cycler.framePercent;
		}
		
		public function set framePercent(value:Number):void
		{
			cycler.framePercent = value;
		}
		
		public function feed(line:Zline2):void{
			if(this.line!=null)
				throw new Error();
			
			this.line=line as Zline2;
		}
		
		public function set fps(value:int):void{
			cycler.fps=value;
		}
		
		public function get frameCount():int{
			if(line==null)
				return 0;
			else
				return line.frameCount;
		}
		
		public function showFrame(frame:int=-1):void
		{
//			trace("show frame",frame,this);
			cycler.pause=true;
			doLoad();
		}
		
		public function cycleEnd():void{
			zebra.onCycleEnd.dispatch();
		}
		
		private function doLoad():void{
			var res:Zframe2=line.getFrame(oldZup,cycler.currentFrame);
			res.vip=true;
			var loader:FrameCarrier=new FrameCarrier();
			loader.frame=res;
			zbox.load(loader);
		}
		
		override public function notifyDispose():void{
			cycler.dispose();
		}
		
		override public function notifyChangeScale():void{
			var newZup:int=zUp;
			if(newZup==oldZup)
				return;
			
			trace("change scale=",zbox.scaleGlobal,"zUp=",zUp,this);
			oldZup=newZup;
			doLoad();
		}
		
		private function get zUp():int{
			var target:int= FastMath.log2(Math.floor(1/(zbox.scaleGlobal*zbox.space.scaleView)));
			return Math.min(target,line.zCount-1);
		}
		
		override public function notifyLoadingFinish():void{
			zbox.scaleFix=FastMath.pow2x(oldZup);
			cycler.pause=false;
		}
		
		public function restartCycle():void{
			framePercent=0;
		}
		
		public function set loop(value:Boolean):void{
			cycler.loop=value;
		}
	}
}