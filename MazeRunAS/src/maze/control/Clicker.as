package maze.control
{
	import azura.avalon.zbase.bus.WayFinder2;
	import azura.common.sound.SoundClip;
	import azura.common.sound.SoundRecorder;
	import azura.touch.gesture.GsingleI;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import maze.GameDisplay;
	
	public class Clicker implements GsingleI
	{
		private var canvas:GameDisplay;
		private var wayFinder:WayFinder2;
		public function Clicker(canvas:GameDisplay)
		{
			this.canvas=canvas;
			wayFinder=new WayFinder2(canvas.rmWalk);
		}
		
		
		public function singleClick(x:Number, y:Number):Boolean
		{
//			trace("single click",x,y,this);
			
			var xt:Number=x+canvas.spaceGround.xView;
			var yt:Number=y+canvas.spaceGround.yView;
			
			if(canvas.hero==null)
				return false;
			
			var startPoint:Point=canvas.hero.body;
			var endPoint:Point=new Point(xt,yt);
			
			var time:Number=getTimer();
			var path:Vector.<Point>;
			path=wayFinder.searchPath(startPoint,endPoint);
//			trace("path finding used time:",getTimer()-time,"ms",this);
			if(path==null){
				trace("no way",this);
				return false;
			}
			
			path.shift();
			
			canvas.goAlong(path);
			
//			SoundRecorder.start();
//			setTimeout(stop,2000);
//			function stop():void{
//				var sc:SoundClip=SoundRecorder.stop();
//				canvas.onSpeak.dispatch(sc.data);
//			}
			
			return false;
		}
		
	}
}