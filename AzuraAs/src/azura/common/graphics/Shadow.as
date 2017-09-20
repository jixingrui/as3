package azura.common.graphics 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	public class Shadow
	{
		
		public static function draw(diameter:int,color:int):BitmapData{
			diameter=Math.max(8,diameter);
			
			var blurSize:int=Math.sqrt(diameter)*1.5;
			
			var sp:Sprite=new Sprite();
			sp.graphics.beginFill(0,0.65);
			sp.graphics.drawEllipse(0,0,diameter,diameter/Math.SQRT2);
			sp.graphics.endFill();
			
			var shadow:BitmapData=new BitmapData(sp.width+blurSize*2,sp.height+blurSize*2,true,0x0);
			var matrix:Matrix=new Matrix();
			matrix.translate(blurSize,blurSize);
			shadow.draw(sp,matrix);
			
			var blur:BlurFilter = new BlurFilter();
			blur.blurX = blurSize; 
			blur.blurY = blurSize; 
			blur.quality = BitmapFilterQuality.MEDIUM;
			shadow.applyFilter(shadow,new
				Rectangle(0,0,shadow.width,shadow.height),new Point(0,0),
				blur);
			
			var ringSize:int=Math.max(24,diameter-12);
			var ringThick:int=12-Math.sqrt(ringSize);
			ringThick=Math.max(4,ringThick);
			ringSize-=ringThick/2;
			
//			var color:int=randBrightColor();
			
			if(color==0)
				return shadow;
			
			matrix=new Matrix();
			matrix.translate((shadow.width-ringSize-ringThick)/2,(shadow.height-(ringSize+ringThick)/Math.SQRT2)/2);
			
			sp.graphics.clear();
			sp.graphics.beginFill(color);
			sp.graphics.drawEllipse(ringThick/2,ringThick/2/Math.SQRT2,ringSize,ringSize/Math.SQRT2);
			sp.graphics.drawEllipse(0,0,ringSize+ringThick,(ringSize+ringThick)/Math.SQRT2);
			sp.graphics.endFill();
			shadow.draw(sp,matrix);
			
			return shadow;
			
		}
		
		public static function randBrightColor():int{
			var color:int=Math.random()*int.MAX_VALUE;
			var channel:int=Math.random()*int.MAX_VALUE%3;
			var rgb:Array=[64,64,64];
			rgb[channel]=128;
			var mask:int=rgb[0]<<16|rgb[1]<<8|rgb[0];
			color|=mask;
			return color;
		}
	}
}