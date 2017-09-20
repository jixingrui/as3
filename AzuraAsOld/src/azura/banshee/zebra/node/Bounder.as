package azura.banshee.zebra.node
{
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	
	public class Bounder
	{
		private var fw:int,fh:int;
		private var pw:int,ph:int;
		public var x:int,y:int;
		
		public function Bounder(screenWidth:int,screenHeight:int,imageWidth:int=0,imageHeight:int=0)
		{
			this.fw=screenWidth;
			this.fh=screenHeight;
			this.pw=imageWidth;
			this.ph=imageHeight;
		}
		
		public function bound(xd:int,yd:int):void{
			x=Math.max⁡(-0.5*(fw-pw)*FastMath.sign(fw-pw),Math.min⁡(xd,0.5*(fw-pw)*FastMath.sign(fw-pw)));
			y=Math.max⁡(-0.5*(fh-ph)*FastMath.sign(fh-ph),Math.min⁡(yd,0.5*(fh-ph)*FastMath.sign(fh-ph)));
		}
	}
}