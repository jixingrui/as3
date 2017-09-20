package azura.avalon.maze3.ui.stationPlayer
{
	import azura.banshee.zebra.node.ZebraNode;
	import azura.common.ui.grid.ItemI;
	
	public class ZebraIcon implements ItemI
	{
		public var zn:ZebraNode;
		private var visible:Boolean;
		
		public function ZebraIcon()
		{
		}
		
		public function gridMoveItem(x:Number,y:Number):void{
			trace("grid move item",this);
		}
		
		public function set gridAlpha(value:Number):void
		{
			zn.renderer.alpha=value;
		}
		
		public function get gridVisible():Boolean
		{
			return visible;
		}
		
		public function set gridVisible(value:Boolean):void
		{
			zn.renderer.visible=value;
			this.visible=value;
		}
	}
}