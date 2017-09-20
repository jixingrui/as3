package azura.banshee.zbox2.collection
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.branch.Zbitmap2;
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.banshee.zbox2.zebra.zimage.ZimageBitmapC2;
	import azura.banshee.zebra.zimage.ZbitmapSprite;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.common.algorithm.FastMath;
	
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	
	public class ZebraLine2 extends ZebraC2
	{
		
		public function ZebraLine2(parent:Zbox2)
		{
			super(parent);
		}
		
		public function paint(color:int,thick:int=1):void{
			var bd:BitmapData=new BitmapData(thick,1,true,color);
			var zebra:Zebra2Old=new Zebra2Old();
			zebra.fromBitmapData(bd);
			super.feed(zebra);
//			zbox.pivotX=zebra.boundingBox.width/2;
//			zbox.pivotY=zebra.boundingBox.height/2;
		}
		
		public function draw(xStart:Number,yStart:Number,xEnd:Number,yEnd:Number):void{
//			var xCenter:Number=(xStart+xEnd)/2;
//			var yCenter:Number=(yStart+yEnd)/2;
//			trace("move",xStart,yStart,xEnd,yEnd,this);
			zbox.replica.scaleY=FastMath.dist(xStart,yStart,xEnd,yEnd);
			var angle:int=FastMath.xy2Angle(xEnd-xStart,yEnd-yStart);
			angle=(angle+180)%360;
			zbox.replica.rotation=angle;
			zbox.move(xStart,yStart);
//			trace("rotation",FastMath.xy2Angle(xEnd-xStart,yEnd-yStart),this);
		}
	}
}