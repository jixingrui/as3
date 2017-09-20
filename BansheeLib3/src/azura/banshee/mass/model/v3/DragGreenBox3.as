package azura.banshee.mass.model.v3
{
	import azura.banshee.mass.view.e.MassTreeNVE2;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class DragGreenBox3 implements GdragI
	{
		public var nve:MassTreeNV3E;
		private var startX:Number;
		private var startY:Number;
		
		public function dragStart(x:Number,y:Number):Boolean
		{
//			trace("drag start",nve.zbox.x,nve.zbox.y,this);
			startX=nve.zbox.x;
			startY=nve.zbox.y;
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			var toX:Number=startX;
			var toY:Number=startY;
			if(nve.model.box.x.int_percent==true)
				toX+=dx;
			if(nve.model.box.y.int_percent==true)
				toY+=dy;
			nve.zbox.move(toX,toY);
			nve.updatePos();
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