package azura.banshee.layers.edit
{
	import azura.avalon.ice.layers.GroundItem;
	import azura.avalon.mouse.MouseDragTargetI;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.ZebraNode;
	import azura.banshee.zplate.ZnodeRoot;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	
	public class DraggerZebra implements MouseDragTargetI
	{
		public var data:GroundItem;
		public var canvas:ZnodeRoot;
//		private var startPoint:Point;
		public var zebra:ZebraNode;
		
		private var layer:MouseDragTargetI;
		public function DraggerZebra(layer:MouseDragTargetI,canvas:ZnodeRoot,zebra:ZebraNode)
		{
			this.layer=layer;
			this.canvas=canvas;
			this.zebra=zebra;
		}
		
		public function dragStart(x:int, y:int):void
		{
			layer.dragStart(x,y);
//			trace("zebra drag start");
//			startPoint=new Point(x,y);
		}
		
		public function dragMove(x:int, y:int):void
		{
			layer.dragMove(x,y);
			zebra.move(canvas.xLocal,canvas.yLocal);
//			var angle:int=FastMath.xy2Angle(startPoint.x-x,startPoint.y-y);
//			trace("zebra drag move "+(canvas.xLocal+x)+","+(canvas.yLocal+y)+","+angle);
//			zebra.move(canvas.xLocal+x-startPoint.x,canvas.yLocal+y-startPoint.y);
//			zebra.rotation=angle;
			
			data.x=zebra.xGlobal;
			data.y=zebra.yGlobal;
			data.pan=zebra.rotation;
			
		}
		
		public function dragEnd(x:int, y:int):void
		{
			layer.dragEnd(x,y);
//			trace("zebra drag end");
		}
		
		public function get priority():int
		{
			return 1;
		}
		
		public function get active():Boolean{
			return true;
		}
	}
}