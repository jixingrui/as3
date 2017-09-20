package azura.banshee.zebra.node
{
	import azura.banshee.zebra.zimage.ZbitmapSprite;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.common.algorithm.FastMath;
	
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	
	public class ZlineNode extends ZboxOld
	{
		private var sprite:ZbitmapSprite;
		
		public function ZlineNode(parent:ZboxOld)
		{
			super(parent);
			sprite=new ZbitmapSprite(this);
		}
		
		public function draw(color:int,thick:int=1):void{
			var bd:BitmapData=new BitmapData(thick,1,true,color);
			sprite.loadBitmapData(bd);
//			shine();
		}
		
		public function shine():void{
			renderer.alpha=0;
			var timeline:TimelineMax = new TimelineMax({repeat:4, yoyo:true, userFrames:true});
			timeline.append(TweenMax.to(renderer, 0.5, {alpha:1}));
		}
		
		public function moveLine(xStart:Number,yStart:Number,xEnd:Number,yEnd:Number):void{
			var xCenter:Number=(xStart+xEnd)/2;
			var yCenter:Number=(yStart+yEnd)/2;
			move(xCenter,yCenter);
			renderer.scaleY=FastMath.dist(xStart,yStart,xEnd,yEnd);
			renderer.rotation=FastMath.xy2Angle(xEnd-xStart,yEnd-yStart);
		}
	}
}