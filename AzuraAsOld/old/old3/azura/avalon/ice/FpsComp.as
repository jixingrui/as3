package old.azura.avalon.ice
{
	
	import com.genome2d.components.GComponent;
	import com.genome2d.node.GNode;
	
	public class FpsComp extends GComponent
	{
		public function FpsComp()
		{
//			super(p_node);
//			node.core.onUpdate.add(FPS.tick);
		}
				
		public function tick():void{
//			trace("update: "+p_deltaTime);
			FPS.tick();
		}
	}
}