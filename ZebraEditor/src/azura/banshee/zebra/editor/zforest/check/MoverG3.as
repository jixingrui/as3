package azura.banshee.zebra.editor.zforest.check
{
	import azura.banshee.zebra.node.Bounder;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.geom.Point;
	
	public class MoverG3 implements GdragI
	{
		private var downRoot:Point;		
		public var bounder:Bounder;
		private var host:LayerZforestCheck3;
		public function MoverG3(host:LayerZforestCheck3)
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
			if(downRoot==null)
				return false;
			if(host.zforest.way==null)
				return false;
			
			var ddx:Number=dx/host.ec.space.scaleLocal;
			var ddy:Number=dy/host.ec.space.scaleLocal;			
			bounder.bound(downRoot.x-ddx,downRoot.y-ddy);
			host.ec.space.look(bounder.x,bounder.y);
			
			var scale:Number=host.zforest.zbaseScale;
			if(host.zforest.way.base.isRoad(bounder.x/scale,bounder.y/scale)){
				host.avatar.zbox.move(bounder.x,bounder.y);
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