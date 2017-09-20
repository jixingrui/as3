package azura.avalon.maze3.ui.woo.cargo
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	[Bindable]
	public class WooCargo implements BytesI
	{
		public static var ZEBRA:int=0;
		public static var PANO:int=1;
		public static var ZUI:int=2;
		public static var CAM:int=3;
		
		public var type:int;
		public var branch:ZintCodecI=new WooZebra();
		
		public function WooCargo()
		{
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			type=zb.readZint();
			if(type==ZEBRA){
				branch=new WooZebra();
			}
			
			branch.readFrom(zb);
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(type);
			branch.writeTo(zb);
			return zb;
		}
		
		public function toString():String{
			return " type["+type+"]";
		}
	}
}