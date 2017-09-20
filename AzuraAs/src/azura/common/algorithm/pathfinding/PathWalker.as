package azura.common.algorithm.pathfinding
{
	
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.mover.MotorI;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class PathWalker implements BytesI
	{
		private var user:MotorI;
		private var current:Point=new Point();
		internal var hopList:Vector.<Point>;
		private var bh:BhStrider;
		public var lastAngle:int;
//		private var lastAngleTime:int;
		
		public function PathWalker(user:MotorI=null){
			this.user=user;
			jumpStart(0,0);
		}
		
		public function clear():void{
			var x:int=current.x;
			var y:int=current.y;
			hopList=new Vector.<Point>()
			bh = new BhStrider(x,y,x,y);
		}
		
		public function jumpStart(x:int,y:int):void{
			current.x=x;
			current.y=y;
			hopList=new Vector.<Point>()
			bh = new BhStrider(x,y,x,y);
		}
		
		public function appendPoint(p:Point):void{
			//			if(hopList.length>=2){
			//				var prev:Point=hopList[hopList.length-2];
			//				var last:Point=hopList[hopList.length-1];
			//				var anglePrev:int=FastMath.xy2Angle(p.x-prev.x,p.y-prev.y);
			//				var angleLast:int=FastMath.xy2Angle(p.x-last.x,p.y-last.y);
			//				var diff:int=Math.abs(anglePrev-angleLast);
			//				trace("diff=",diff,this);
			//				if(diff<15){
			//					hopList[hopList.length-1]=p;
			//				}
			//			}else{
			//				trace("hopList length=",hopList.length,this);
			hopList.push(p);
			//			}
		}
		
		public function appendPath(path:Vector.<Point>):void{
			if(path==null || path.length==0)
				return;
			
			//filter
			for each(var p:Point in path){
				if(p!=null && !p.equals(current))
					hopList.push(p);
			}
		}
		
		public function next(stride:int):Point{
			
			stride = Math.max(stride,1);
			var passed:int = bh.stepForward(stride);
			if (passed == stride) {
				return new Point(bh.xNow, bh.yNow);
			} else if (hopList.length>0) {
				var hop:Point = hopList.shift();
				bh=new BhStrider(bh.xNow, bh.yNow, hop.x, hop.y);
				checkTurn(hop.x-bh.xNow,hop.y-bh.yNow);
				return next(stride - passed);
			} else if (passed > 0) {
				return new Point(bh.xNow, bh.yNow);
			} else {
				return null;
			}
		}
		
		private function checkTurn(dx:int,dy:int):void{
			if(user!=null &&(dx!=0||dy!=0)){
				var angle:int=FastMath.xy2Angle(dx,dy);
				if(lastAngle!=angle){
					
//					var timeDiff:int=getTimer()-lastAngleTime;
//					var angleDiff:int=Math.abs(angle-lastAngle);
					//					trace("time diff=",timeDiff,this);
//					lastAngleTime=getTimer();						
//					if(timeDiff<500 && angleDiff<20){
//						return;
//					}
					
					lastAngle=angle;					
					user.turnTo(angle);
				}
			}
		}
		
		public function get pathLength():int{
			return hopList.length;
		}
		
		public function get currentDist():Number{
			if(bh==null)
				return 0;
			else
				return FastMath.dist(bh.xNow,bh.yNow,bh.xDest,bh.yDest);
		}
		
		public function get tailPoint():Point{
			if(hopList.length>0)
				return hopList[hopList.length-1];
			else if(bh!=null)
				return new Point(bh.xDest,bh.yDest);
			else 
				return null;
		}
		
		public function toBytes():ZintBuffer{
			var zb:ZintBuffer= new ZintBuffer();
			if (bh == null) {
				zb.writeZint(hopList.length);
			} else {
				zb.writeZint(hopList.length + 1);
				zb.writeZint(bh.xDest);
				zb.writeZint(bh.yDest);
			}
			for each(var step :Point in hopList) {
				zb.writeZint(step.x);
				zb.writeZint(step.y);
			}
			return zb;
		}
		
		public function fromBytes(zb:ZintBuffer):void{
			appendPath(extract(zb));
		}
		
		public static function extract(zb:ZintBuffer):Vector.<Point>{
			var result:Vector.<Point>=new Vector.<Point>();
			var size:int=zb.readZint();
			for(var i:int=0;i<size;i++){
				var p:Point=new Point(zb.readZint(),zb.readZint());
				result.push(p);
			}
			return result;
		}
	}
}