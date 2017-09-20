package azura.banshee.maze
{
	import azura.avalon.mouse.MouseDragTargetI;
	import azura.avalon.mouse.MouseManager;
	import azura.banshee.zebra.ZebraPlate;
	import azura.banshee.zebra.i.ZimageRendererI;
	import azura.banshee.zplate.ZebraRendererG2d;
	import azura.banshee.zplate.Zplate;
	
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	
	public class ZebraDraggable extends ZebraPlate implements MouseDragTargetI
	{
		public function ZebraDraggable(parent:Zplate, renderer:ZimageRendererI)
		{
			super(parent, renderer);
			node.mouseEnabled=true;
			node.onMouseDown.add(onMouseDown);
			node.onMouseMove.add(onMouseMove);
			node.onMouseUp.add(onMouseUp);
		}
		
		private function get node():GNode{
			return ZebraRendererG2d(renderer).node;
		}
		
		private function onMouseDown(g:GNodeMouseSignal):void{
			MouseManager.singleton().mouseDown(this,0,0);
		}
		
		private function onMouseMove(g:GNodeMouseSignal):void{
			MouseManager.singleton().mouseMove(this,0,0);
		}
		
		private function onMouseUp(g:GNodeMouseSignal):void{
			MouseManager.singleton().mouseUp(this,0,0);
		}
		
		public function dragStart(x:int, y:int):void
		{
			trace("door drag start");
		}
		
		public function dragMove(x:int, y:int):void
		{
			trace("door drag move");
		}
		
		public function dragEnd(x:int, y:int):void
		{
			trace("door drag end");
		}
		
		public function get priority():int
		{
			return 1;
		}
	}
}