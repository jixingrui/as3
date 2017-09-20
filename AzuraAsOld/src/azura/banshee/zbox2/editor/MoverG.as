package azura.banshee.zbox2.editor
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class MoverG implements GdragI
	{
		private var downActor:Point;
		private var host:LayerZebra2;
		public function MoverG(host:LayerZebra2)
		{
			this.host=host;
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			downActor=new Point(host.actor.zbox.x,host.actor.zbox.y);
			return true;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			host.actor.zbox.move(downActor.x+dx,downActor.y+dy);
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