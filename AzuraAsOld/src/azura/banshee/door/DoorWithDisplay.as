package azura.banshee.door
{
	import azura.banshee.zebra.box.AbBoxI;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.i.ZmazeI;

	public class DoorWithDisplay implements AbBoxI
	{
		public function DoorWithDisplay(layer:ZmazeI)
		{
			this.layer=layer;
		}
		
		private var layer:ZmazeI;
		public var data:Door;
		public var icon:ZebraNode;
		
//		public function register():void{
//			view.onClick.add(onClick);
//			icon.observer=this;
//		}
		
		public function get priority():int
		{
			return 1;
		}
		
		public function zboxTouched():Boolean
		{
			trace("click door",data.uid,this);
			layer.onDoorClick.dispatch(data);
			return true;
		}
		
//		public function onClick():void{
//			layer.onDoorClick.dispatch(data);
//		}
	}
}