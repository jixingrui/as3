package azura.banshee.zbox3.zebra.zmatrix
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.engine.FrameCarrier;
	import azura.banshee.zebra.branch.Zline2;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	
	import flash.geom.Point;
	
	public class ZvlineC3 extends Zbox3Container 
	{
		private var line:Zline2;
		private var loadingRow:int=-1;
		private var oldZup:int=0;
		
		public function ZvlineC3(parent:Zbox3)
		{
			super(parent);
		}
		
		public function feed(data:Zline2):void{
			this.line=data;
			loadingRow=rowByAngle;
			doLoad();
		}
		
		override public function notifyChangeScale():void{
			var newZup:int=zUp;
			if(newZup==oldZup)
				return;
			
			trace("change scale=",zbox.scaleGlobal,"zUp=",zUp,this);
			oldZup=newZup;
			doLoad();
		}
		
		private function doLoad():void{
			var res:Zframe2=line.getFrame(oldZup,loadingRow);
			res.vip=true;
			var loader:FrameCarrier=new FrameCarrier();
			loader.frame=res;
//			loader.loader=zbox.replica.loader;
			zbox.load(loader);
		}		
		
		override public function notifyLoadingFinish():void{
//			trace("loading finish",this);
			zbox.scaleFix=FastMath.pow2x(oldZup);
//			trace("scale fix=",zbox.scaleFix,this);
		}
		
		override public function notifyChangeAngle():void{
			var targetRow:int=rowByAngle;
			if(targetRow!=loadingRow){
				loadingRow=targetRow;				
				doLoad();
			}
		}		
		
		private function get rowByAngle():int{
			if(line==null)
				return 0;
			
			var flat:Point=FastMath.angle2Xy(zbox.angleGlobal);
			var top:Point=Neck.flatToTop(flat.x,flat.y,0);
			var _angle:Number=FastMath.xy2Angle(top.x,top.y);
			return (_angle+180/line.frameCount)%360/360*line.frameCount;
		}
		
		private function get zUp():int{
			var target:int= FastMath.log2(Math.floor(1/(zbox.scaleGlobal*zbox.space.scaleView)));
			return Math.min(target,line.zCount-1);
		}
	}
}