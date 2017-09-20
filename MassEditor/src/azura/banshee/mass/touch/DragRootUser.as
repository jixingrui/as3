package azura.banshee.mass.touch
{
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.mass.layer.ZuiEditLayer;
	import azura.touch.gesture.GdragI;
	import azura.touch.TouchBox;
	
	public class DragRootUser implements GdragI
	{
		private var target:ZboxOld;
		public function DragRootUser(target:ZboxOld)
		{
			this.target=target;
		}
		
		private var xStart:Number;
		private var yStart:Number;
		public function dragStart():Boolean
		{
			xStart=target.box.pos.x;
			yStart=target.box.pos.y;
			return true;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			target.move(xStart+dx,yStart+dy);
//			ZuiEditLayer.instance.ref.move(target.box.pos.x,target.box.pos.y);
			return true;
		}
		
		public function dragEnd():Boolean
		{
			return true;
		}
		
		private var touchBox_:TouchBox;
		public function get touchBox():TouchBox
		{
			return touchBox_;
		}
		
		public function set touchBox(box:TouchBox):void
		{
			this.touchBox_=box;
		}
	}
}