package azura.banshee.zebra.editor.ztree
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class SetRootG3 implements GdragI
	{
		private var host:ZtreeEditor3Canvas;
		
		public function SetRootG3(host:ZtreeEditor3Canvas)
		{
			this.host=host;
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			host.ztree.rootX=x;
			host.ztree.rootY=y;
			host.cross.zbox.move(x,y);
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