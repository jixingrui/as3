package azura.banshee.zebra
{
	import azura.banshee.zebra.i.ZebraI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Rectangle;
	
	public class Zempty implements ZebraI
	{
		public function Zempty()
		{
		}
		
		public function get width():int
		{
			return 0;
		}
		
		public function get height():int
		{
			return 0;
		}
		
		public function get boundingBox():Rectangle{
			return new Rectangle();
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
		
		public function clear():void
		{
		}
		
		public function getMe5List():Vector.<String>
		{
			return new Vector.<String>();
		}
	}
}