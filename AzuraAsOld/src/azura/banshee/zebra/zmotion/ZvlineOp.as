package azura.banshee.zebra.zmotion
{
	import azura.banshee.zebra.i.ZmatrixOpI;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ZvlineOp implements ZmatrixOpI
	{
		private var _angle:int;
		private var line:ZlineSp;
		private var ret:Function;
		
		public function ZvlineOp(line:ZlineSp)
		{
			this.line=line;
		}
		
		public function get framePercent():int
		{
			return line.framePercent;
		}
		
		public function set framePercent(value:int):void
		{
			line.framePercent=value;
		}
		
		public function get boundingBox():Rectangle{
			return line.currentFrame.boundingBox;
		}
		
		public function load(angle:int,ret_ZmatrixOp:Function):void{
			this.ret=ret_ZmatrixOp;
			this.angle=angle;
			line.load(onLoaded);
		}
		
		private var showing:Boolean;
		public function show():void{
			showing=true;
			line.showFrame(frame);
		}
		
		public function set fps(value:int):void{
		}
		
		public function set angle(value:int):void
		{
			var flat:Point=FastMath.angle2Xy(value);
			var top:Point=Neck.flatToTop(flat.x,flat.y,0);
			_angle=FastMath.xy2Angle(top.x,top.y);
			
			//			line.load(onLoaded);
			//			line.showFrame(frame);
			if(showing){
				line.showFrame(frame);
			}
		}
		
		public function onLoaded(op:ZlineSp):void{
			//			if(ret!=null){
			ret.call(null,this);
			ret=null;
			//			}else{
			//				show();
			//			}
		}
		
		private function get frame():int{
			return (_angle+180/line.frameCount)%360/360*line.frameCount;
		}
		
		public function set scale(value:Number):void
		{
			//			line.zUp=value;
		}
		
		//		public function cancel():void{
		//			line.cancel();
		//		}
		
		public function dispose():void{
			line.dispose();
		}
		
	}
}