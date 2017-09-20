package azura.banshee.zebra.editor.zpano
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class DragPano implements GdragI
	{
		public function DragPano()
		{
		}
		
		public function dragStart():Boolean
		{
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			return false;
		}
		
		public function dragEnd():Boolean
		{
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