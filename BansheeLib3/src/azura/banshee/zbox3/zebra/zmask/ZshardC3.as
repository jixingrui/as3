package azura.banshee.zbox3.zebra.zmask
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zbox3.container.Zbox3ReplicaI;
	import azura.banshee.zbox3.engine.FrameCarrier;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.banshee.zebra.data.wrap.Zsheet2;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ZshardC3 extends Zbox3Container implements Zbox3ControllerI
	{
		public var host:Zbox3;
		private var bb:Rectangle;
		
		public var sheet:Zsheet2;
		public var subId:String;
		public var boundingBox:Rectangle;
		public var rectOnSheet:Rectangle;
		
		public var driftX:Number=0;
		public var driftY:Number=0;
		public var depth:Number=0;
		public var scale:Number=1;
		public var alpha:Number=1;
		
		public function ZshardC3(host:Zbox3){
			super(host);
		}
		
		public function getBB(axis:Point,angle:Number):Rectangle{
			var rad:Number=FastMath.angle2radian(angle);
			return FastMath.rotateRectangle(axis,bb,rad);
		}
		
//		override public function notifyInitialized():void{
//			trace("init",this);
//		}
		
		public function display(frame:Zframe2):void{
			bb=frame.boundingBox;
			var link:FrameCarrier=new FrameCarrier();
			link.frame=frame;
			link.center_LT=false;
//			link.pivotX=driftX;
//			link.pivotY=driftY;
			zbox.replica.smoothing=false;
			zbox.load(link);
			
//			zbox.x=driftX;
//			zbox.y=driftY;
			zbox.sortValue=depth;
			zbox.alpha=alpha;
			zbox.move(driftX,depth);
		}
		
	}
}
