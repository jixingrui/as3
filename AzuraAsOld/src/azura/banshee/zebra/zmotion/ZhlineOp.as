package azura.banshee.zebra.zmotion
{
	import azura.banshee.zebra.i.ZmatrixOpI;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.i.ZRspriteI;
	import azura.common.algorithm.mover.Cycler;
	
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	
	public class ZhlineOp implements ZmatrixOpI
	{
		private var cycler:Cycler=new Cycler();
		private var line:ZlineSp;
		private var ret:Function;

		public function ZhlineOp(line:ZlineSp,fps:int)
		{
			this.line=line;
			this.fps=fps;
		}

		public function get framePercent():int
		{
			return line.framePercent;
		}

		public function set framePercent(value:int):void
		{
			line.framePercent=value;
		}
		
		public function set fps(value:int):void
		{
			cycler.fps=value;
		}
		
		public function get boundingBox():Rectangle{
			return line.currentFrame.boundingBox;
		}
		
		public function load(angle:int,ret_ZmatrixOp:Function):void{
			this.ret=ret_ZmatrixOp;
			line.load(lineLoaded);
		}
		
		public function lineLoaded(op:ZlineSp):void{
			ret.call(null,this);
		}
		
		public function show():void{
			cycler.target=line;
//			line.showFrame();
		}
		
		public function set angle(angle:int):void
		{
		}
		
		public function set scale(value:Number):void
		{
			line.scale=value;
		}
		
		public function dispose():void{
			cycler.dispose();
			line.sleep();
		}
		
	}
}