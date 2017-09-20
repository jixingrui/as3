package azura.banshee.chessboard.loaders
{
	import azura.banshee.chessboard.dish.TileDish;
	import azura.banshee.starling.ATF;
	import azura.gallerid.Gal_Http;
	
	import common.async.AsyncBoxI;
	import common.async.AsyncQue;
	import common.async.AsyncTask;
	import common.async.AsyncUserA;
	import common.collections.ZintBuffer;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class PlateLoader extends AsyncUserA
	{
		public static var Mosaic:int=0;
		public static var Clear:int=1;
		public static var Minimap:int=2;
		
		{
			AsyncQue.configSerial("minimap",10000,0,2);
			AsyncQue.configSerial("mosaic",10000,0,3);
			AsyncQue.configSerial("clear",20000,0,5);
		}
		public static function load(tile:TileDish,ret_TileDish_Image:Function,userType:int):PlateLoader{
			var loader:PlateLoader=new PlateLoader(tile,ret_TileDish_Image);
			switch(userType)
			{
				case Minimap:
					AsyncQue.enque("minimap",loader,false);
					break;
				case Mosaic:
					AsyncQue.enque("mosaic",loader,false);
					break;
				case Clear:
					AsyncQue.enque("clear",loader,false);
					break;				
				default:
					break;
			}
			return loader;
		}
		
		private var ret_TileDish_Image:Function;
		public var image:Image;
		
		public function PlateLoader(tile:TileDish,ret_TileDish_Image:Function)
		{
			super(tile);
			this.ret_TileDish_Image=ret_TileDish_Image;
		}
		
		private function get tile():TileDish{
			return key as TileDish;
		}
		
		override public function process(answer:AsyncTask):void
		{
			Gal_Http.load(TileDish(key).md5Plate[ATF._type],fileLoaded);
			function fileLoaded(gh:Gal_Http):void{				
				var zb:ZintBuffer=new ZintBuffer(gh.value);
				zb.uncompress();
				Texture.fromAtfData(zb,1,false,texLoaded);
			}
			function texLoaded(tex:Texture):void{
				var box:PlateBox=new PlateBox();
				box.image=new Image(tex);
//				box.image.touchable=false;
				box.image.smoothing='none';
				
				answer.submit(box);
			}
		}
		
		override public function ready(value:AsyncBoxI):void
		{
			this.image=PlateBox(value).image;
			ret_TileDish_Image.call(null,key,image);
		}
		
//		override public function discard():Boolean{
//			return super.discard();
//		}
	}
}