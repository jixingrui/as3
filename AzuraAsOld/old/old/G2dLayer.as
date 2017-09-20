package azura.avalon.ice.g2d
{
	import com.genome2d.Genome2D;
	import com.genome2d.components.GCameraController;
	import com.genome2d.node.GNode;
	import com.genome2d.node.factory.GNodeFactory;

	public class G2dLayer
	{
		public var node:GNode;
//		private var camera:GCameraController;
		
		public function G2dLayer()
		{
//			node=GNodeFactory.createNode();
//			Genome2D.getInstance().root.addChild(node);
//			node.cameraGroup=idx;
			
//			camera=GNodeFactory.createNodeWithComponent(GCameraController) as GCameraController;
//			camera.contextCamera.mask=idx;
//			Genome2D.getInstance().root.addChild(camera.node);
		}
		
		public function set active(value:Boolean):void{
			node.parent.mouseEnabled=value;
		}
		
		public function enterFrame():void{
//			Genome2D.getInstance().render(camera);
		}
		
//		public function clear():void{
//			node.disposeChildren();
//		}
	}
}