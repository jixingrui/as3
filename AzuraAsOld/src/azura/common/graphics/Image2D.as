package azura.common.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	import spark.core.SpriteVisualElement;
	
	public class Image2D extends SpriteVisualElement
	{
		private var bitmap:Bitmap;
		
		private var _onClick:Signal=new Signal();
		
		public function Image2D()
		{
			super();
			bitmap=new Bitmap(new BitmapData(1, 1, true, 0));
//			bitmap.smoothing=true;
			addChild(bitmap);
			addEventListener(MouseEvent.MOUSE_DOWN,onClickLocal);
			function onClickLocal(event:MouseEvent):void{
				onClick.dispatch();
			}
		}	
		
		public function get onClick():Signal
		{
			return _onClick;
		}
		
		public function set mc5(value:String):void{
			if(value==null||value.length!=42)
			{
				clear();
				return;
			}
//			Gallerid.singleton().getData(value).onReady.add(fileReady);
//			function fileReady(item:GalMail):void{
//				BitmapDataLoader.load(bdReady,item.dataClone());
//			}
//			function bdReady(bd:BitmapData):void{
//				bitmapData=bd;
//			}
			//			new Gal_Http2Old(value).load(onDataReady);
			//			function onDataReady(gh:Gal_Http2Old):void{
			//				new JpgLoader(gh.value,onBdReady);
			//				function onBdReady(bd:BitmapData):void{
			//					_bitmapData=bd;
			//				}
			//			}
		}
		
		public function get bitmapData():BitmapData{
			return bitmap.bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void
		{			
			bitmap.bitmapData=value;
		}
		
		public function clear():void{
			bitmap.bitmapData=new BitmapData(1,1,true,0);
		}
		
		private function clicked(event:MouseEvent):void
		{			
			if (hittest(bitmapData, event.localX, event.localY))
			{
				event.stopImmediatePropagation();
				var e:ClickEvent=new ClickEvent(ClickEvent.Body);
				this.dispatchEvent(e);
			}
		}
		
		private static function hittest(bd:BitmapData, x:int, y:int):Boolean
		{
			var point:Point=new Point(x, y);
			return bd.hitTest(new Point(0, 0), 0, point);
		}
	}
}