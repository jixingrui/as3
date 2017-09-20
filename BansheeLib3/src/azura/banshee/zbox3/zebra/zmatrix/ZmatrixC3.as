package azura.banshee.zbox3.zebra.zmatrix
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.zebra.LoopControlI;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.branch.Zmatrix2;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	
	import flash.geom.Point;
	
	public class ZmatrixC3 extends Zbox3Container implements LoopControlI
	{
		private var data:Zmatrix2;
		private var currentRow:int=-1;
		public var currentLine:ZhlineC3M;
		private var nextLine:ZhlineC3M;
		private var zebra:ZebraC3;
		private var loop_:Boolean;
		
		public function ZmatrixC3(parent:Zbox3,zebra:ZebraC3)
		{
			super(parent);
			this.zebra=zebra;
			zbox.onReplaceParent.add(replaceLine);
		}
		
		public function feed(data:Zmatrix2):void{
			this.data=data;
			
			reload();
		}
		
		public function set fps(value:int):void{
			if(currentLine!=null)
				currentLine.fps=value;
		}
		
		override public function notifyChangeAngle():void{
			if(currentRow==rowByAngle)
				return;
			reload();
		}		
		
		public function restartFrame():void{
			currentLine.framePercent=0;
		}
		
		private function reload():void{
			var nextRow:int=rowByAngle;
			
			currentRow=nextRow;
			
			var framePercent:Number=0;
			if(currentLine!=null)
				framePercent=currentLine.framePercent;
			
			nextLine=new ZhlineC3M(zbox,zebra,this);
			if(currentLine!=null){
				currentLine.zbox.replaceBy(nextLine.zbox);
			}else{
				currentLine=nextLine;
				currentLine.loop=loop_;
			}
			//			nextLine.feed(data.rowList[rowByAngle],2);
			nextLine.feed(data.rowList[rowByAngle]);
			nextLine.fps=data.fps;
			nextLine.framePercent=framePercent;
			//			nextLine.frameAdvance();
			//			trace("change line, frame from",currentLine,this);
		}
		
		public function replaceLine(newGuy:Zbox3):void{
			//			trace("replaced line",this);
			currentLine=nextLine;
			currentLine.loop=loop_;
		}
		
		private function get rowByAngle():int{
			if(data==null)
				return 0;
			
			var flat:Point=FastMath.angle2Xy(zbox.angleGlobal);
			var top:Point=Neck.flatToTop(flat.x,flat.y,0);
			var _angle:Number=FastMath.xy2Angle(top.x,top.y);
			return (_angle+180/data.rowCount)%360/360*data.rowCount;
		}
		
		public function restartCycle():void{
			currentLine.framePercent=0;
		}
		
		public function set loop(value:Boolean):void{
			loop_=value;
			currentLine.loop=value;
		}
	}
}