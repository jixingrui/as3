package zmask.old
{
	
	import azura.banshee.zebra.data.wrap.Zsheet2;
	
	import flash.geom.Rectangle;

	public class ZframeOp
	{
		public var sheet:Zsheet2;
		public var subId:String;
		public var boundingBox:Rectangle;
		public var rectOnSheet:Rectangle;
		
		public var driftX:Number=0;
		public var driftY:Number=0;
		public var depth:Number=0;
		public var scale:Number=1;
		public var alpha:Number=1;
	}
}