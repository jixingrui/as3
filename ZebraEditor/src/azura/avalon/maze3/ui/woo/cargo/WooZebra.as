package azura.avalon.maze3.ui.woo.cargo
{
	import azura.banshee.zebra.Zebra;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	public class WooZebra implements ZintCodecI
	{
		public var zebra:Zebra=new Zebra();
		
		public function readFrom(zb:ZintBuffer):void
		{
			zebra.fromBytes(zb);
		}
		
		public function writeTo(zb:ZintBuffer):void
		{
			zb.writeBytes(zebra.toBytes());
		}
	}
}