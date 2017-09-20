package azura.banshee.zbox2.zebra.zmatrix
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.branch.Zmatrix2;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	
	import flash.geom.Point;
	
	public class ZmatrixC2 extends Zbox2Container implements Zbox2ControllerI
	{
		private var data:Zmatrix2;
		private var currentLine:ZhlineC2;
		
		public function ZmatrixC2(parent:Zbox2)
		{
			super(parent,true);
		}
		
		public function feed(data:Zmatrix2):void{
			this.data=data;
			
			reload();
		}
		
		override public function notifyChangeAngle():void{
			reload();
		}		
		
		override public function notifyChangeScale():void{
			
		}
		
		private function reload():void{
				
			var framePercent:Number=0;
			if(currentLine!=null)
				framePercent=currentLine.cycler.framePercent;
			
			currentLine=new ZhlineC2(zbox);
			currentLine.feed(data.rowList[rowByAngle],data.fps);
			currentLine.cycler.framePercent=framePercent;
		}
		
		private function get rowByAngle():int{
			var flat:Point=FastMath.angle2Xy(zbox.angleGlobal);
			var top:Point=Neck.flatToTop(flat.x,flat.y,0);
			var _angle:Number=FastMath.xy2Angle(top.x,top.y);
			return (_angle+180/data.rowCount)%360/360*data.rowCount;
		}
		
	}
}