package oldold
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.avalon.map.AvalonMapUserI;
	
	import common.collections.ZintBuffer;
	import azura.gallerid.Gal_Http;
	
	import flash.display.BitmapData;
	import azura.avalon.fi.mask.MaskShard;
	
	
	public class CopyofTileMask extends TileFi
	{
		public var shardList:Vector.<MaskShard>=new Vector.<MaskShard>();
		public var shardImageReady:Boolean,shardDataReady:Boolean,httpLoading:Boolean;
		internal var md5:String;
		private var tempImage:BitmapData;
		private var xScreen:Number,yScreen:Number;
		private var scale:Number;
		
		public function CopyofTileMask(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
		}
		
		public function positionFurniture(xScreen:Number,yScreen:Number,scale:Number):void{	
			this.xScreen=xScreen;
			this.yScreen=yScreen;
			this.scale=scale;
			
			if(shardDataReady){
				positionFurniture_();
			}else{
				loadFromHttp();
			}
		}
		
		public function remove():void{
			for(var i:int=0;i<shardList.length;i++){
//				user._remove(getKey(i,fi));
			}		
		}		
		
		public function carve(image:BitmapData):void{
			if(shardImageReady){
				updateFurniture();
			}else if(shardDataReady){
				tempImage=image;	
				carve_();				
			}else{
				loadFromHttp();
			}
		}		
		
		private function positionFurniture_():void{
			for(var i:int=0;i<shardList.length;i++){
				var shard:MaskShard=shardList[i];
				var key:String=getKey(i,fi);
//				user._positionFurniture(key,xScreen+shard.x*scale,yScreen+shard.y*scale,shard.depth);					
			}
		}
		
		private function loadFromHttp():void{
			if(httpLoading)
				return;
			
			httpLoading=true;
			Gal_Http.load(md5,loaded);
			function loaded(zb:ZintBuffer):void{
				httpLoading=false;
				
				//load
				zb=zb.clone();
				zb.uncompress();
				while(!zb.isEmpty()){
					var shard:MaskShard=new MaskShard(zb.readBytes_());
					shardList.push(shard);				
				}	
				shardDataReady=true;
				
				//position
				positionFurniture_();
				
				//update
				if(tempImage!=null){
					carve_();
				}	
			}
		}
		
		private function carve_():void{
			for each(var shard:MaskShard in shardList){
				shard.carve(tempImage);
			}			
			shardImageReady=true;
			tempImage=null;
			updateFurniture();
		}
		
		private function updateFurniture():void{
			for(var i:int=0;i<shardList.length;i++){
				var shard:MaskShard=shardList[i];
				var key:String=getKey(i,fi);				
//				user._updateFurniture(key,shard.bd);
			}
		}
		
//		private function get user():AvalonMapUserI{
//			return PyramidMask(pyramid).user;
//		}
		
		private function getKey(idx:int,fi:int):String{
			return idx+'@'+fi;
		}
	}
}