package azura.avalon.maze3.ui.woo
{
	import azura.banshee.zebra.box.AbBoxI;
	import azura.banshee.zebra.node.ZebraNode;
	
	public class Closer implements AbBoxI
	{
		public var host:ZebraNode;
		
		public function Closer(zn:ZebraNode)
		{
			this.host=zn;
		}
		
		public function get priority():int
		{
			return 0;
		}
		
		public function zboxTouched():Boolean
		{
			host.dispose();
			return true;
		}
	}
}