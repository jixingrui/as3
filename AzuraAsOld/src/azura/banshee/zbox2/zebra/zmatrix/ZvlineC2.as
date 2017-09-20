package azura.banshee.zbox2.zebra.zmatrix
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.branch.ZVline2;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	
	import flash.geom.Point;
	
	public class ZvlineC2 extends Zbox2Container implements Zbox2ControllerI
	{
		private var data:ZVline2;
		private var loadingRow:int=-1;
		
		public function ZvlineC2(parent:Zbox2)
		{
			super(parent,true);
		}
		
		public function feed(data:ZVline2):void{
			this.data=data;
			var zUp:int=targetZup;
			loadingRow=rowByAngle;
			zbox.load(data.line.getFrame(zUp,loadingRow),zUp);
		}
		
		override public function notifyChangeAngle():void{
			var targetRow:int=rowByAngle;
			var zUp:int=targetZup;
			if(targetRow!=loadingRow){
				loadingRow=targetRow;				
				zbox.load(data.line.getFrame(zUp,loadingRow),zUp);
			}
		}		
		
		override public function notifyChangeScale():void{
			var zUp:int=targetZup;
			if(zbox.loadingZup!=zUp)
				zbox.load(data.line.getFrame(zUp,loadingRow),zUp);
		}
		
		private function get targetZup():int{
			return Math.min(zbox.zUpGlobal,data.line.zCount-1);
		}
		
		private function get rowByAngle():int{
			var flat:Point=FastMath.angle2Xy(zbox.angleGlobal);
			var top:Point=Neck.flatToTop(flat.x,flat.y,0);
			var _angle:Number=FastMath.xy2Angle(top.x,top.y);
			return (_angle+180/data.line.frameCount)%360/360*data.line.frameCount;
		}
		
	}
}