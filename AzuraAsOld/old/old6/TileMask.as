package azura.avalon.fi.mask.old
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	
	import azura.common.collections.ZintBuffer;
	
	import flash.display.BitmapData;
	
	
	public class TileMask extends TileFi
	{
		public var shardList:Vector.<MaskShard>=new Vector.<MaskShard>();
		
		public function TileMask(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
		}
						 		
		public function load(zb:ZintBuffer):void{
			while(!zb.isEmpty()){
				var shard:MaskShard=new MaskShard(zb.readBytes_());
				shardList.push(shard);				
			}	
		}
		
		public function remove():void{
			for(var i:int=0;i<shardList.length;i++){
				user._removeShard(this,i);
			}		
		}		
		
		public function putImage(bd:BitmapData):void{			
			for(var i:int=0;i<shardList.length;i++){
				var shard:MaskShard=shardList[i];
				var bdShard:BitmapData=shard.carve(bd);
				user._updateShard(this,i,bdShard,super.cx*256+shard.x,super.cy*256+shard.y,shard.depth-pyramid.bound/2*256);
			}				
		}		
				
		private function get user():MaskUserI{
			return PyramidMask(pyramid).user;
		}
		
	}
}
