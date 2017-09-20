package azura.avalon.maze.canvas.old
{
	import azura.banshee.door.GroundItem;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.layers.LayerZforestDrag;
	import azura.banshee.zebra.node.ZebraNode;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import azura.avalon.maze.Door;
	
	public class LayerZforestEditOld extends LayerZforestDrag implements SwampEditI
	{
		private var item:Door;
		public var doorIcon:ZebraNode;
		
		public function LayerZforestEditOld(gl:G2dLayer)
		{
			super(gl);
		}
		
		override public function init():void{
			super.init();
		}
		
		public function putHere(gi:GroundItem):void{
			this.item=gi as Door;
			doorIcon.move(root.xRoot,root.yRoot);
		}
		
		public function editItem(gi:GroundItem):void
		{
			this.item=gi as Door;
			stopEditing();
			doorIcon=new ZebraNode(zforest.footLayer);
			
			Stage3DRoot.singleton().stage.addEventListener(KeyboardEvent.KEY_DOWN,onPress);
			root.lookAt(item.x+item.dx,item.y+item.dy);
			
			doorIcon.move(item.x,item.y);
			doorIcon.angle=item.pan;
			doorIcon.mc5=item.mc5;
		}
		
		public function stopEditing():void
		{
			if(doorIcon!=null){
				
				doorIcon.dispose();
				doorIcon=null;
			}
			Stage3DRoot.singleton().stage.removeEventListener(KeyboardEvent.KEY_DOWN,onPress);
		}
		
		protected function onPress(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.A:
				{
					doorIcon.angle--;
					item.pan=doorIcon.angle;
					break;
				}
				case Keyboard.D:
				{
					doorIcon.angle++;
					item.pan=doorIcon.angle;
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		override public function dispose():void
		{
			stopEditing();
			super.dispose();
		}
	}
}