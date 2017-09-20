package azura.common.ui.bubble
{
	import azura.common.algorithm.FastMath;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class BubbleMaker extends Sprite
	{
		private var textField:TextField=new TextField();
		private var format:TextFormat=new TextFormat();
		
		public function BubbleMaker()
		{
//			format.font="Microsoft YaHei";
			format.font="微软雅黑";
			format.size=20;
//			format.bold=true;
			format.color=0xffffff;
			
			addChild(textField);
		}
		
		public static function make(text:String,frameWidth:int,head:Point,beak:int):Bubble{
//			trace("w="+frameWidth+" p="+head);
			
			var bm:BubbleMaker=new BubbleMaker();
			bm.update(text);
			bm.reposition(frameWidth,head,beak);
			
			var b:Bubble=new Bubble();
			var bound:Rectangle=bm.getBounds(bm);
			b.bd=new BitmapData(bound.width,bound.height,true,0x0);
			
			var matrix:Matrix = new Matrix();
			matrix.translate(-bound.x, -bound.y);
			
			b.bd.draw(bm,matrix);
			
			b.drift.x=bound.x-head.x;
			b.drift.y=bound.y-head.y;
			
			return b;
		}
		
		private function update(text:String):void{
			textField.text=text;
			textField.setTextFormat(format);
			textField.multiline = false;
			textField.wordWrap = false;
			textField.autoSize = TextFieldAutoSize.CENTER;
			textField.selectable=false;
			
			var maxWidth:Number = 240;
			if (textField.width > maxWidth)
			{
				textField.multiline = true;
				textField.wordWrap = true;
				textField.width = maxWidth;
			}
			
		}
		
		private function reposition(frameWidth:int,head:Point,beak:int):void{
			
			var rect:Rectangle=new Rectangle();
			
			rect=new Rectangle(0,0,textField.width+10,textField.height+10);
			rect.width=Math.max(rect.width,40);
			
			var rc:Point=new Point();
			rc.x=head.x+rect.width/2+beak;				
			rc.y=head.y-rect.height/2-beak;
			if(rc.x+rect.width/2>frameWidth)
				rc.x=head.x-rect.width/2-beak;
			if(rc.y<rect.height/2)
				rc.y=head.y+rect.height/2+beak;
			
			var k:Number=Math.abs((rc.y-head.y)/(rc.x-head.x));
			
			var nose:Point=new Point();
			
			nose.x=head.x+beak*k*FastMath.sign(rc.x-head.x);
			nose.y=head.y+beak*k*FastMath.sign(rc.y-head.y);
			
			rect.x=rc.x-rect.width/2;
			rect.y=rc.y-rect.height/2;
			
			textField.x=rect.x+5;
			textField.y=rect.y+5;
			
			var g:Graphics = graphics;				
			g.clear();
			g.beginFill(0x777777, 0.7);								
			g.lineStyle(2,0x555555,1,true);				
			SpeechBubble.drawSpeechBubble(g,20,rect,nose);
			g.endFill();
			
		}
	}
}