package azura.banshee.zebra.editor.ztree
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class EraserG2 implements GdragI
	{
		private var host:ZtreeEditor2Canvas;
		
		public function EraserG2(host:ZtreeEditor2Canvas)
		{
			this.host=host;
		}
		
		public function dragStart():Boolean
		{
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			host.paint(x,y,0xffffff);
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