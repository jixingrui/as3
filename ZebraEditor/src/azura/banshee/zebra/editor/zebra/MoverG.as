package azura.banshee.zebra.editor.zebra
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class MoverG implements GdragI
	{
		private var downActor:Point;
		private var host:LayerZebra;
		public function MoverG(host:LayerZebra)
		{
			this.host=host;
		}
		
		public function dragStart():Boolean
		{
			downActor=new Point(host.actor.xGlobal,host.actor.yGlobal);
			return true;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			host.actor.move(downActor.x+dx,downActor.y+dy);
			return true;
		}
		
		public function dragEnd():Boolean
		{
			return true;
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