package azura.common.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import spark.core.SpriteVisualElement;
	
	public class ImageDrift extends SpriteVisualElement
	{
		private var bitmap:Bitmap;
		private var drift:Point=new Point();
		
		public function ImageDrift()
		{
			bitmap=new Bitmap(new BitmapData(1, 1, true, 0));
			addChild(bitmap);
		}
		
		public function _clear():void{
			_bitmapData=new BitmapData(1,1,true,0);
		}
		
		public function get _bitmapData():BitmapData{
			return bitmap.bitmapData;
		}
		
		public function set _bitmapData(bd:BitmapData):void{
			bitmap.bitmapData=bd;	
			//			bitmap.smoothing=true;
		}
		
		public function set _xDrift(dx:int):void{
			drift.x=dx;
			update();
		}
		
		public function set _yDrift(dy:int):void{
			drift.y=dy;
			update();
		}
		
		private function update():void{
			bitmap.x=-drift.x;
			bitmap.y=-drift.y;
		}
		
		override public function set x(value:Number):void{
			super.x=value;
			update();
		}
		
		override public function set y(value:Number):void{
			super.y=value;
			update();
		}
	}
}