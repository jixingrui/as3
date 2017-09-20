package azura.banshee.zebra.branch
{
	import azura.banshee.zebra.data.wrap.TextureLoaderI;
	import azura.banshee.zebra.data.wrap.Zatlas2;
	import azura.banshee.zebra.data.wrap.Zframe2ListenerI;
	import azura.common.collections.ZintBuffer;
	
	import flash.display.BitmapData;
	
	public class Zbitmap3 implements ZbitmapI
	{
		private var _bitmapData:BitmapData;
		public var nativeTexture_:Object;
		private var loader:TextureLoaderI;
		
//		public function Zbitmap2(bd:BitmapData)
//		{
//			this.bitmapData=bd;
//		}
		
		private var _smoothing:Boolean=true;
		
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}

		public function set bitmapData(value:BitmapData):void
		{
			_bitmapData = value;
		}

		public function get smoothing():Boolean
		{
			return _smoothing;
		}
		
		public function set smoothing(value:Boolean):void
		{
			_smoothing = value;
		}
		
		public function get nativeTexture():Object{
			return nativeTexture_;
		}
		
		public function set nativeTexture(value:Object):void{
			this.nativeTexture_=value;
		}
		
		public function get dx():Number{
			return 0;
		}
		
		public function get dy():Number{
			return 0;
		}
		
		public function get width():Number{
			return bitmapData.width;
		}
		
		public function get height():Number{
			return bitmapData.height;
		}
		
		public function startUse(user:Zframe2ListenerI, loader:TextureLoaderI):void
		{
			this.loader=loader;
			loader.fromBitmap(this);
			user.notifyZframe2Loaded();
		}
		
		public function endUse(user:Zframe2ListenerI):void
		{
			loader.unloadBitmap(this);
		}
		
		public function set atlas(value:Zatlas2):void
		{
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
		}
	}
}