package
{
	import azura.banshee.zbox3.Zspace3;
	import azura.banshee.zbox3.collection.ZboxRect3;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class LineDragger implements GdragI
	{
		public var space:Zspace3;
		public var scope:ZboxRect3;
		
		public function LineDragger(space:Zspace3,frame:ZboxRect3)
		{
			this.space=space;
			this.scope=frame;
		}
		
		public var xStart:Number=0;
		public var yStart:Number=0;
		public function dragStart(x:Number,y:Number):Boolean
		{
			xStart=space.xView;
			yStart=space.yView;
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
//			space.look(-x,-y);
			space.look(xStart-dx/space.scaleView,yStart-dy/space.scaleView);
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