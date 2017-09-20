package azura.avalon.fi.land
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	
	import common.collections.ObjectCache;
	import common.loaders.AjpgLoader;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.utils.Dictionary;
	
	public class TileLand extends TileFi
	{		
		private static var md5Empty:String='42edab5db6812945f37483fce0b379dd';
		
		internal var md5:String;
		private var cache:ObjectCache=new ObjectCache();
		private var _observed:Boolean;
		private var _upToDate:Boolean;
		private var trueLoading:Boolean;
		private var fiLower_TileLand:Dictionary=new Dictionary();
		
		public function TileLand(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
		}
		
		public function set observed(value:Boolean):void
		{
			var old:Boolean=_observed;
			_observed = value;
			if(old==false && value==true){
				requestImage();
			}
		}
		
		private function requestImage():void{
			var image:BitmapData=cache.getObj();
			
			if(image!=null){
				serveImage(image);
				askUp(false);
			}else{
				_upToDate=false;
				askUp(true);				
			}
			
			if(!_upToDate){
				trueLoad();
			}
			
		}
		
		private function askUp(requestImage:Boolean):void{
			var up:TileLand=upper as TileLand;
			if(up!=null){
				if(requestImage)
					up.fiLower_TileLand[fi]=this;
				
				up.requestImage();
			}
		}
		
		private function serveImage(image:BitmapData):void{
			cache.put(image);
			if(_observed){
				PyramidLand(pyramid).update(this,image);
			}
			for each(var lower:TileLand in fiLower_TileLand){
				var isStillRequesting:Boolean=lower.receiveFromUp(image);
				if(!isStillRequesting||_upToDate){
					delete fiLower_TileLand[lower.fi];
				}
			}
		}
		
		private function trueLoad():void{
			if(trueLoading){
				return;
			}
			
			if(md5==''||md5==md5Empty){
				_upToDate=true;
			}else{			
				trueLoading=true;
				AjpgLoader.load(argbLoaded,md5);
				function argbLoaded(image:BitmapData):void{		
					trueLoading=false;		
					
					_upToDate=true;	
					serveImage(image);
				}	
			}
		}
		
		/**
		 * 
		 * @param imageUpper
		 * @return is still requesting
		 * 
		 */
		private function receiveFromUp(imageUpper:BitmapData):Boolean{
			if(_upToDate)
				return false;		
			
			var half:int=imageUpper.width/2;
			var px:int=this.x%2*half;
			var py:int=this.y%2*half;	
			var rect:Rectangle=new Rectangle(px,py,half,half);
			var quarter:BitmapData=new BitmapData(half,half,true,0x0);
			quarter.copyPixels(imageUpper,rect,new Point());	
			cache.put(quarter);
			
			serveImage(quarter);
			
			return true;
		}
	}
}