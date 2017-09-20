package azura.banshee.zebra.editor.zforest
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.zebra.node.Bounder;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class MoveScreenG3 implements GdragI
	{
		private var downRoot:Point;		
		public var bounder:Bounder;
		private var host:ZforestEditor3Canvas;
		public function MoveScreenG3(host:ZforestEditor3Canvas)
		{
			this.host=host;
		}
		
		public function dragStart(x:Number,y:Number):Boolean
		{
			downRoot=new Point(host.ec.space.xView,host.ec.space.yView);
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			var ddx:Number=dx/host.ec.space.scaleView;
			var ddy:Number=dy/host.ec.space.scaleView;			
			bounder.bound(downRoot.x-ddx,downRoot.y-dy);
			host.ec.space.look(bounder.x,bounder.y);
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