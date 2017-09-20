package azura.banshee.editor.layers.zpano
{
	import away3d.containers.ObjectContainer3D;
	
	import azura.banshee.engine.a3d.A3dLayer;
	import azura.banshee.zebra.i.SwampI;
	
	import azura.banshee.door.DoorData;
	
	import flash.utils.Dictionary;
	
	public class LayerZpanoArrow extends LayerZpanoBg 
	{
		public var itemLayer:ObjectContainer3D;
		private var Arrow_Arrow:Dictionary=new Dictionary();
		
		public function LayerZpanoArrow(al:A3dLayer)
		{
			super(al);
		}
		
		override public function init():void{
			super.init();
			itemLayer=new ObjectContainer3D();
			al.view.scene.addChild(itemLayer);
		}
		
		override public function dispose():void{
			itemLayer.disposeWithChildren();
			super.dispose();
		}
		
		override public function showDoor(door:DoorData):void{
			var arrow:ArrowClicker=new ArrowClicker(stage,door,this);
			Arrow_Arrow[arrow]=arrow;
		}
	}
}