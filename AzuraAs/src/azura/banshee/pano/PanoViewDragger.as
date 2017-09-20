package azura.banshee.pano
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class PanoViewDragger implements GdragI
	{
		public var host:PanoViewer;
		
		public function PanoViewDragger()
		{
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			host.dragStart();
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			host.dragMove(x,y,dx,dy);
			return false;
		}
		
		public function dragEnd():Boolean
		{
			host.dragEnd();
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