package azura.banshee.zbox3.collection
{
	import azura.banshee.zbox3.Zbox3;
	import azura.common.algorithm.FastMath;
	
	import flash.display.BitmapData;
	
	public class ZboxLine3 extends ZboxBitmap3
	{
		
		public function ZboxLine3(parent:Zbox3)
		{
			super(parent);
		}
		
		public function paint(color:int,thick:int=1):void{
			var bd:BitmapData=new BitmapData(thick,1,true,color);
			fromBitmapData(bd,true);
		}
		
		override public function notifyChangeScale():void{
			zbox.replica.scaleXImage=1/(zbox.scaleGlobal*zbox.space.scaleView);
//			trace("scale",zbox.replica.scaleXImage,this);
		}
		
		override public function notifyInitialized():void{
			notifyChangeScale();
//			zbox.replica.scaleXImage=1/(zbox.scaleGlobal*zbox.space.scaleView);
		}
		
		public function draw(xStart:Number,yStart:Number,xEnd:Number,yEnd:Number):void{
//			trace("xStart",xStart,"yStart",yStart,"xEnd",xEnd,"yEnd",yEnd,this);
			zbox.replica.scaleYImage=FastMath.dist(xStart,yStart,xEnd,yEnd);
			var angle:int=FastMath.xy2Angle(xEnd-xStart,yEnd-yStart);
			angle=(angle+180)%360;
			zbox.replica.rotation=angle;
			zbox.move(xStart,yStart);
		}
	}
}