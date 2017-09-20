package azura.banshee.zebra.zode
{
	import azura.banshee.g2d.TextureLoaderBase;
	import azura.banshee.zebra.atlas.Zatlas;
	import azura.banshee.zebra.atlas.Zsheet;
	import azura.common.async2.AsyncLoader2;
	import azura.gallerid3.Gallerid;
	import azura.gallerid4.Gal4;
	
	import flash.display.BitmapData;
	
	import org.osflash.signals.Signal;
	
	public class ZsheetOp
	{
		//texture type
		public static var Init:int=0;
		public static var Empty:int=1;
		public static var Alpha:int=2;
		public static var Solid:int=3;
		public static var PngJpg:int=4;
		public static var BitmapData_:int=5;
		public var textureType:int=Alpha;
		
		//usage type
		public static var Land:int=10;
		public static var Mask:int=11;
		public static var Anim:int=12;
		public var usageType:int=Land;
		
		public var me5:String;
		public var bitmapData:BitmapData;
		
		public var isLoaded:Boolean;
		public var nativeTexture:*;
		public var loader:TextureLoaderBase;
		public var onLoaded:Signal=new Signal();
		
		public function dispose():void{
			isLoaded=false;
			nativeTexture=null;
			if(loader!=null)
				loader.release(9000);
		}
	}
}
