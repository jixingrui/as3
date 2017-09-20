package azura.common.graphics
{
	import azura.banshee.zebra.Zfont;
	import azura.common.algorithm.FastMath;
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Draw
	{
		public static function turnRed(bd:BitmapData):void{
			for(var i:int=0;i<bd.width;i++){
				for(var j:int=0;j<bd.height;j++){
					if(bd.getPixel32(i,j)!=0){
						bd.setPixel32(i,j,0xffff0000);
					}
				}
			}
		}
		
		public static function drawOval(g:Graphics, centerX:Number, centerY:Number, xRadius:Number, yRadius:Number):void{
			g.moveTo(centerX + xRadius,  centerY);
			
			var sides:int=(xRadius+yRadius)/Math.PI;
			for(var i:int=0; i<=sides; i++){
				var pointRatio:Number = i/sides;
				var radians:Number = pointRatio * 2 * Math.PI;
				var xSteps:Number = Math.cos(radians);
				var ySteps:Number = Math.sin(radians);
				//
				// Change "radius" to "xRadius".
				var pointX:Number = centerX + xSteps * xRadius;
				//
				// Change "radius" to "yRadius".
				var pointY:Number = centerY + ySteps * yRadius;
				//
				g.lineTo(pointX, pointY);
			}
		}
		
		public static function text(text:String,color:int=0xff0000ff):BitmapData {
			
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.text = text;
			tf.textColor = color;
			tf.autoSize=TextFormatAlign.LEFT;
			tf.antiAliasType=AntiAliasType.ADVANCED;
			
			var format:TextFormat = new TextFormat();
			format.size=Number(28);
			format.bold=true;
			tf.setTextFormat(format);
			
			var outline:GlowFilter=new GlowFilter(0xffffff,1,2,2,4);
			outline.quality=BitmapFilterQuality.MEDIUM;
			tf.filters=[outline];
			
			tf.cacheAsBitmap = true;
			
			var result:BitmapData=new BitmapData(tf.width,tf.height,true,0x0);
			result.draw(tf);	
			
			return result;
		}
		
		public static function font(zfont:Zfont):BitmapData {
			
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.text = zfont.text;
			tf.textColor = zfont.color;
			tf.autoSize=TextFormatAlign.LEFT;
			tf.antiAliasType=AntiAliasType.ADVANCED;
			
			var format:TextFormat = new TextFormat();
			format.size=Number(zfont.size);
			format.bold=true;
			tf.setTextFormat(format);
			
			if(zfont.glowStrength>0){
				var outline:GlowFilter=new GlowFilter(zfont.glowColor,1,2,2,zfont.glowStrength);
				outline.quality=BitmapFilterQuality.HIGH;
				tf.filters=[outline];
			}
			
			tf.cacheAsBitmap = true;
			
			var w:Number=Math.min(2048,tf.width);
			var h:Number=Math.min(2048,tf.height);
			
			var result:BitmapData=new BitmapData(w,h,true,0x0);
			result.draw(tf);	
			
			return result;
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
		
		public static function focus(size:int,color:int):BitmapData{
			var canvas:BitmapData=new BitmapData(size,size,true,color);
			//			var eraser:BitmapData=new BitmapData(size,size,true,0x0);
			
			//			var sp:Sprite=new Sprite();
			//			sp.graphics.beginFill(0xffffff,1);
			//			var gap:Number=Math.sqrt(size)/2;
			//			sp.graphics.drawEllipse(-gap,-gap,size+2*gap,size+2*gap);
			//			sp.graphics.endFill();
			
			var sp:Sprite=new Sprite();
			sp.graphics.beginFill(0xffffff,1);
			sp.graphics.drawRect(0,0,size,size);
			sp.graphics.endFill();
			
			var matrix:Matrix=new Matrix();
			matrix.rotate(FastMath.angle2radian(45));
			matrix.translate(size/2,size*(0.5-Math.SQRT2/2));
			canvas.draw(sp,matrix,null,BlendMode.ERASE);
			
			//			matrix=new Matrix();
			//			matrix.translate(size,0);
			//			matrix.rotate(FastMath.toRadians(45));
			//			matrix.scale(Math.SQRT2/2,0.5);
			//			
			//			var img:BitmapData=new BitmapData(size,size,true,0x0);
			//			//			matrix.translate(size,0);
			//			//			matrix.scale(Math.SQRT2/2,0.5);
			//			img.draw(canvas,matrix);
			
			return canvas;
		}
		
		public static function circle(radius:int,color:int):BitmapData{			
			var sp:Sprite=new Sprite();
			sp.graphics.beginFill(color);
			sp.graphics.drawCircle(radius,radius,radius);
			sp.graphics.endFill();
			
			var circle:BitmapData=new BitmapData(sp.width,sp.height,true,0x0);
			circle.draw(sp);
			
			return circle;
		}
		
		public static function shadow(diameter:int,color:int):BitmapData{
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
		
		//		public static function shadow():BitmapData{
		//			var bdShadow:BitmapData=new BitmapData(48,48,true,0x0);
		//			
		//			var shape:Shape=new Shape();
		//			shape.graphics.beginFill(0x0,0.3);
		//			shape.graphics.drawEllipse(0,12,48,24);
		//			//			shape.graphics.drawEllipse(4,12,24,12);
		//			shape.graphics.endFill();
		//			
		//			bdShadow.draw(shape);
		//			
		//			return bdShadow;
		//		}
		
		public static function scope(r:int):BitmapData{
			var image:Sprite=new Sprite();
			var thick:int=Math.max(1,r/10);
			
			image.graphics.lineStyle(thick,0x0000ff,1);		
			image.graphics.moveTo(0,r);
			image.graphics.lineTo(r*2-thick,r);
			image.graphics.moveTo(r,0);
			image.graphics.lineTo(r,r*2-thick);
			
			image.graphics.lineStyle(thick,0xff0000,1);		
			image.graphics.drawCircle(r,r,r-thick/2);
			
			var bd:BitmapData= sprite2BitmapData(image.width,image.height,image);
			for(var i:int=r-1;i<=r+1;i++)
				for(var j:int=0;j<3;j++)
					bd.setPixel32(i,j,0xff00ff00);
			
			return bd;
		}
		
		public static function box(l:int):BitmapData{
			return new BitmapData(l,l,false,0xffff0000);
		}
		
		public static function cross(width:int,height:int,thick:int=1,color:int=0xff0000):BitmapData{
			
			var halfW:Number=width/2;
			var halfH:Number=height/2;
			
			var image:Sprite=new Sprite();
			
			image.graphics.lineStyle(thick,color,1,true);
			
			image.graphics.moveTo(0,halfH);
			image.graphics.lineTo(halfW*2,halfH);
			image.graphics.moveTo(halfW,0);
			image.graphics.lineTo(halfW,halfH*2);
			
			image.graphics.endFill();
			
			return sprite2BitmapData(width,height,image);
		}
		
		public static function ruler(width:int,height:int,color:int=0xcccccc):BitmapData{
			var halfW:Number=width/2;
			var halfH:Number=height/2;
			
			var image:Sprite=new Sprite();
			
			//			image.graphics.beginFill(0x999999,1);
			//			image.graphics.drawRect(0,0,width,height);
			
			image.graphics.lineStyle(1,color);
			
			image.graphics.moveTo(0,halfH);
			image.graphics.lineTo(halfW*2,halfH);
			image.graphics.moveTo(halfW,0);
			image.graphics.lineTo(halfW,halfH*2);
			
			image.graphics.moveTo(0,0);
			image.graphics.lineTo(halfW*2,halfH*2);
			image.graphics.moveTo(0,halfH*2);
			image.graphics.lineTo(halfW*2,0);
			
			image.graphics.endFill();
			
			return sprite2BitmapData(width,height,image);
		}
		
		private static function sprite2BitmapData(w:int,h:int,image:Sprite):BitmapData{
			var bd:BitmapData=new BitmapData(w,h,true,0x0);
			bd.draw(image);			
			return bd;
		}
		private static function sprite2BitmapDataTest(w:int,h:int,image:Sprite):BitmapData{
			var bd:BitmapData=new BitmapData(w,h,false,0x00ff00);
			bd.draw(image);			
			return bd;
		}
		
		public static function scale(bitmapData:BitmapData, scale:Number):BitmapData {
			scale = Math.abs(scale);
			var width:int = (bitmapData.width * scale) || 1;
			var height:int = (bitmapData.height * scale) || 1;
			var transparent:Boolean = bitmapData.transparent;
			var result:BitmapData = new BitmapData(width, height, transparent,0x0);
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			result.draw(bitmapData, matrix);
			return result;
		}		
		
		public static function rotate(target:Sprite,dx:Number,dy:Number,angle:Number):void{
			if(angle==0)
				return;
			
			var dist:Number = Math.sqrt( dx * dx + dy * dy );
			
			var a:Number = Math.atan2(dy, dx) * 180 / Math.PI;
			var offset:Number = 180 - a;
			
			var ra:Number = (angle - offset) * Math.PI / 180;
			
			target.x += dx+ Math.cos(ra) * dist;
			target.y += dx+ Math.sin(ra) * dist;
			
			target.rotation =  angle;
		}
	}
}