package azura.banshee.mass.touch
{
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.mass.editor.MassPanel;
	import azura.banshee.mass.graphics.old.ZuiTreeNodeDisplayOld;
	import azura.banshee.mass.model.MassBox;
	import azura.touch.gesture.GdragI;
	import azura.touch.TouchBox;
	
	public class DragBoxUser implements GdragI
	{
		private var target:ZuiTreeNodeDisplayOld;
		public function DragBoxUser(box:ZuiTreeNodeDisplayOld)
		{
			this.target=box;
		}
		
		private var xStart:Number;
		private var yStart:Number;
		public function dragStart():Boolean
		{
			xStart=target.box.pos.x;
			yStart=target.box.pos.y;
			return true;
		}
		
		private function get box():MassBox{
			return MassPanel.instance.boxPanel._zuiBox;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			if(draggable)
				target.move(xStart+dx,yStart+dy);
			return true;
		}
		
		private function get draggable():Boolean{
			return box.align==5&&box.x.int_percent==true&&box.y.int_percent==true;
		}
		
		public function dragEnd():Boolean
		{
			if(draggable){
				box.x.value=target.box.pos.x;
				box.y.value=target.box.pos.y;
				MassPanel.instance.boxPanel_changeHandler(null);
			}
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