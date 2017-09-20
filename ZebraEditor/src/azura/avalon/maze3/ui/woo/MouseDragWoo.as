package azura.avalon.maze3.ui.woo
{
	import azura.avalon.zbase.zway.WayDot45;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.common.algorithm.FastMath;
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.mouserOld.MouserDragI;
	
	import flash.geom.Point;
	
	public class MouseDragWoo implements MouserDragI
	{		
		private var host:LayerMaze3WooEdit;	
		private var lastScreen:Point;
		private var downWoo:Point;	
		
		public function MouseDragWoo(host:LayerMaze3WooEdit)
		{
			this.host=host;
		}
		
		public function onDragStart(md:MouserDrag):void
		{
			var x:Number=md.position.x;
			var y:Number=md.position.y;
			
			lastScreen=new Point(x,y);
			downWoo=new Point(host.root.xView+x,host.root.yView+y);
		}
		
		public function onDragMove(md:MouserDrag):void
		{			
			var dx:Number=-md.delta.x/host.root.root.scaleLocal;
			var dy:Number=-md.delta.y/host.root.root.scaleLocal;		
			
			var x:Number=md.position.x;
			var y:Number=md.position.y;
			
			host.selectedWooNode.move(downWoo.x-dx,downWoo.y-dy);
			host.selectedWooNode.angle=FastMath.xy2Angle(x-lastScreen.x,y-lastScreen.y);
			
			lastScreen.x=(lastScreen.x*49+x)/50;
			lastScreen.y=(lastScreen.y*49+y)/50;
		}
		
		public function onDragEnd(md:MouserDrag):void
		{
			var dest:Point=new Point();
			dest.x=host.root.xView+md.position.x;
			dest.y=host.root.yView+md.position.y;
			var wn:WayDot45=host.wayFinder.pointToNode(dest.x,dest.y);
			var group:int=-1;
			if(wn!=null){
				group=wn.group;
				
				host.woo.inRegion=group;
				
				host.woo.icon.x=dest.x;
				host.woo.icon.y=dest.y;
//				host.woo.dx=host.x-host.woo.dx;
//				host.woo.dy=host.y-host.woo.dy;
				host.woo.icon.angle=host.selectedWooNode.angle;			
				host.selectedWooNode.move(dest.x,dest.y);
				host.panel.drWoo.save();
			}else{
				trace('not way',this);
			}
			trace("the woo is in region",group,this);
			
			host.mouseMode=LayerMaze3WooEdit.MOUSEDRAGSCREEN;
		}
	}
}