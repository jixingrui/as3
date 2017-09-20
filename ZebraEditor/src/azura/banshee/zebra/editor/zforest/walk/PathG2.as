package azura.banshee.zebra.editor.zforest.walk
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GsingleI;
	
	import flash.geom.Point;
	
	public class PathG2 implements GsingleI
	{
		private var current:Point=new Point();
		private var host:LayerZforestWalk2;
		public function PathG2(host:LayerZforestWalk2)
		{
			this.host=host;
		}
		
		public function singleClick(x:Number,y:Number):Boolean
		{
			var xg:int=host.ec.space.viewX+x;
			var yg:int=host.ec.space.viewY+y;
			
//			trace("from",current.x,current.y,"to",xg,yg,this);
			
			if(!host.wayFinder.start(current.x,current.y)){
				current.x=xg;
				current.y=yg;
				host.jumpTo(xg,yg);
				return false;
			}else if(!host.wayFinder.end(xg,yg)){
//				host.drawPoint(xg,yg,0xff888888,4);
				return false;
			}else{
				current.x=xg;
				current.y=yg;
				var path:Vector.<Point>=host.wayFinder.searchPath();
				//				for each(var min:Point in path){
				//					host.drawPoint(min.x,min.y,0xffff0000,3);
				//				}
				
				host.walkAlong(path);
			}
			return false;
		}
		
		public function get touchBox():TouchBox
		{
			return null;
		}
		
		public function set touchBox(box:TouchBox):void
		{
		}
	}
}