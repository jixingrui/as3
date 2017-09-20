package azura.banshee.zebra.editor.zforest
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.zebra.node.Bounder;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class MoveScreenG implements GdragI
	{
		private var downRoot:Point;		
		public var bounder:Bounder;
		private var host:LayerZforestEditor;
		public function MoveScreenG(host:LayerZforestEditor)
		{
			this.host=host;
		}
		
		public function dragStart():Boolean
		{
			downRoot=new Point(host.root.xView,host.root.yView);
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			var ddx:Number=dx/host.root.scaleLocal;
			var ddy:Number=dy/host.root.scaleLocal;			
			bounder.bound(downRoot.x-ddx,downRoot.y-dy);
			host.root.lookAt(bounder.x,bounder.y);
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