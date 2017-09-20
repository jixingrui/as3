package azura.banshee.zebra.editor.zpano
{
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	public class MoverG implements GdragI
	{
		private var host:LayerZpanoPure;
		
		public function MoverG(host:LayerZpanoPure)
		{
			this.host=host;
		}
		
		public function dragStart():Boolean
		{
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			if(!host.dragging){
				host.downMouseX = x;
				host.downMouseY = y;
				host.downPanAngle = host.al.camera.panAngle;
				host.downTiltAngle = host.al.camera.tiltAngle;
				host.dragging=true;
			}
			
			host.mouseX=x;
			host.mouseY=y;
			return false;
		}
		
		public function dragEnd():Boolean
		{
			host.dragging=false;
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