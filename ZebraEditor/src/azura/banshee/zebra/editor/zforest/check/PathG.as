package azura.banshee.zebra.editor.zforest.check
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GsingleI;
	
	import flash.geom.Point;
	
	public class PathG implements GsingleI
	{
		private var start_end:Boolean=true;
		private var host:LayerZforestCheck;
		public function PathG(host:LayerZforestCheck)
		{
			this.host=host;
		}
		
		public function singleClick(x:Number,y:Number):Boolean
		{
			var xg:int=host.root.xView+x;
			var yg:int=host.root.yView+y;
			
			if(start_end){
				
				host.clearDots();
				
				if(!host.wayFinder.start(xg,yg)){
					host.drawPoint(xg,yg,0xff888888,4);
					return false;
				}
				
				start_end=false;
				host.drawPoint(xg,yg,0xff00ff00,5);
				
				host.mouseMode=LayerZforestCheck.mouse_move;
			}else{
				
				if(!host.wayFinder.end(xg,yg)){
					host.drawPoint(xg,yg,0xff888888,4);
					return false;
				}
				
				start_end=true;
				host.drawPoint(xg,yg,0xff00ff00,5);
				
				var path:Vector.<Point>=host.wayFinder.searchPath();
				
				var i:int;
				for(i=0;i<path.length-1;i++){
					host.drawLine(path[i].x,path[i].y,path[i+1].x,path[i+1].y);
				}
				
				host.mouseMode=LayerZforestCheck.mouse_move;
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