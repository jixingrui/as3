package
{
	import azura.banshee.mass.editor.TouchView;
	import azura.banshee.mass.editor.TouchViewI;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdoubleI;
	import azura.touch.gesture.GdragI;
	import azura.touch.gesture.GdropI;
	import azura.touch.gesture.GhoverI;
	import azura.touch.gesture.GsingleI;
	import azura.touch.gesture.GzoomI;
	
	import flash.geom.Point;
	
	public class TouchUser implements GhoverI, GsingleI, GdoubleI, GdragI, GdropI, GzoomI
	{
		public var view:TouchViewI;
		
		private var box:TouchBox;
		public function get touchBox():TouchBox{
			return box;
		}
		public function set touchBox(box:TouchBox):void{
			this.box=box;
		}
		
		public function singleClick(x:Number, y:Number):Boolean
		{
//			trace("user: select",this);
			return false;
		}
		
		public function doubleClick():Boolean
		{
//			trace("user: double",this);
			return false;
		}
		
		private var downPos:Point;
		public function dragStart():Boolean
		{
			downPos=new Point(view.xCenter,view.yCenter);
//			trace("user: drag start",this);
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			view.xCenter=downPos.x+dx;
			view.yCenter=downPos.y+dy;
			box.box.xc=view.xCenter;
			box.box.yc=view.yCenter;
			box.updatePos();
//			trace("user: drag move",x,y,dx,dy,this);
			return false;
		}
		
		public function dragEnd():Boolean
		{
//			trace("user: drag end",this);
			return false;
		}
		
		public function hover():Boolean
		{
			trace("user: over",this);
//			TouchView(view).fill(0xff0000);
			return false;
		}
		
		public function out():Boolean
		{
			trace("user: out",this);
//			TouchView(view).fill(0x0000ff);
			return false;
		}
		
		public function drop(target:TouchBox):Boolean
		{
//			trace("user: drop",this);
			return false;
		}
		
		public function zoom(scaleXD:Number,scaleYD:Number):Boolean{
//			trace("user: scale",scaleXD,scaleYD,this);
			return false;
		}
	}
}