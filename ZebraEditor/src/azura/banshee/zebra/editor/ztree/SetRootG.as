package azura.banshee.zebra.editor.ztree
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class SetRootG implements GdragI
	{
		private var host:LayerZtreeEdit;
		
		public function SetRootG(host:LayerZtreeEdit)
		{
			this.host=host;
		}
		
		public function dragStart():Boolean
		{
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			host.ztree.rootX=x;
			host.ztree.rootY=y;
			host.cross.move(x,y);
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