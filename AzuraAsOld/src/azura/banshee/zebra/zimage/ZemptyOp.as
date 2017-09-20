package azura.banshee.zebra.zimage
{
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.i.ZebraBranchNodeI;
	import azura.banshee.zebra.i.ZebraI;
	
	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	public class ZemptyOp implements ZebraBranchNodeI
	{
		public function ZemptyOp()
		{
		}
		
		public function load(value:Zebra,ret:Function):void
		{
		}
		
		public function get boundingBox():Rectangle{
			return null;
		}
		
		public function show():void{
			
		}
		
		public function look(viewLocal:Rectangle):void
		{
		}
		
		public function set angle(value:Number):void
		{
			angle_=value;
		}		
		private var angle_:Number=0;
		public function get angle():Number
		{
			return angle_;
		}
		
		public function dispose():void
		{
		}
		
	}
}