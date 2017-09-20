package azura.pyramid.g2d
{
	import azura.banshee.zimage.i.ZplateRendererI;
	
	import com.genome2d.components.GComponent;
	import com.genome2d.node.GNode;
	
	public class ZplateG2d extends GComponent implements ZplateRendererI
	{
		public function ZplateG2d(p_node:GNode)
		{
			super(p_node);
		}
		
		public function move(x:Number, y:Number, depth:Number):void
		{
			node.transform.x=x;
			node.transform.y=y;
			node.userData["depth"]=depth;
		}
		
		public function scale(s:Number):void
		{
			node.transform.scaleX=s;
			node.transform.scaleY=s;
		}
		
		public function addChild(value:ZplateRendererI):void{
			var child:ZplateG2d=value as ZplateG2d;
			this.node.addChild(child.node);
		}
		
		public function removeChild(value:ZplateRendererI):void{
			var child:ZplateG2d=value as ZplateG2d;
			this.node.removeChild(child.node);
		}
		
		public function sortChildren():void{
			node.sortChildrenOnUserData("depth",false);
		}
	}
}