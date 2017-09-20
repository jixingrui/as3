package maze.tween
{
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.mover.EnterFrame;
	import azura.common.algorithm.mover.EnterFrameI;
	import azura.common.algorithm.mover.FPS;
	import azura.common.algorithm.pathfinding.BhStrider;
	
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	

	public class FrameStrider implements EnterFrameI
	{
		private var maxStride:int;
		private var strider:BhStrider;
		public var onStep:Signal=new Signal(Point);
		
		public function FrameStrider(maxStride:int)
		{
			this.maxStride=maxStride;
		}
		
		public function go(xStart:int,yStart:int,xEnd:int,yEnd:int):void{
			stop();
			strider=new BhStrider(xStart,yStart,xEnd,yEnd);
			EnterFrame.addListener(this);
		}
		
		public function enterFrame():void{
			var stride:int;
			var dist:Number=FastMath.dist(strider.xNow,strider.yNow,strider.xDest,strider.yDest);
			if(dist==0){
				stop();
			}else	if(dist<maxStride){
				stride=Math.max(1,dist*0.5);
			}else{
				stride=maxStride;
			}
			strider.step(stride);
			var p:Point=new Point(strider.xNow,strider.yNow);
			onStep.dispatch(p);
		}
		
		public function stop():void{
			EnterFrame.removeListener(this);
		}
	}
}