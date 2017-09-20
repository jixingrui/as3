package azura.banshee.mass.editor
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import spark.core.SpriteVisualElement;
	
	public class TouchView extends SpriteVisualElement implements TouchViewI
	{
		private var bd:BitmapData;
		private var b:Bitmap;
//		private var _xCenter:Number;
//		private var _yCenter:Number;
		
		public function TouchView(width:Number,height:Number)
		{
			super();
			bd=new BitmapData(width,height,false,0x0000ff);
			b=new Bitmap(bd);
			super.addChild(b);
			b.x=-width/2;
			b.y=-height/2;
		}
		
		public function fill(color:int):void{
			bd.fillRect(bd.rect,color);
		}

		public function get xCenter():Number
		{
			return x;
		}

		public function set xCenter(value:Number):void
		{
			x = value;
		}

		public function get yCenter():Number
		{
			return y;
		}

		public function set yCenter(value:Number):void
		{
			y = value;
		}

	}
}