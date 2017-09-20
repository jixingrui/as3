package azura.banshee.zebra.editor.zforest.check
{
	import azura.banshee.zebra.node.Bounder;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class MoverG implements GdragI
	{
		private var downRoot:Point;		
		public var bounder:Bounder;
		private var host:LayerZforestCheck;
		public function MoverG(host:LayerZforestCheck)
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
			if(downRoot==null)
				return false;
			if(host.zforest.way==null)
				return false;
			
			var ddx:Number=dx/host.root.scaleLocal;
			var ddy:Number=dy/host.root.scaleLocal;			
			bounder.bound(downRoot.x-ddx,downRoot.y-ddy);
			host.root.lookAt(bounder.x,bounder.y);
			
			var scale:Number=host.zforest.zbaseScale;
			if(host.zforest.way.base.isRoad(bounder.x/scale,bounder.y/scale)){
				host.avatar.move(bounder.x,bounder.y);
			}
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