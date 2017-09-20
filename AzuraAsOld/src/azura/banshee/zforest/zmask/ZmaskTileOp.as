package azura.banshee.zforest.zmask
{
	import azura.banshee.zebra.atlas.Zframe;
	import azura.banshee.zebra.node.ZmaskNode;
	import azura.banshee.zebra.zode.ZatlasOp;
	import azura.banshee.zebra.zode.Zshard;
	import azura.banshee.zebra.zode.ZframeOp;
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class ZmaskTileOp
	{
		public var node:ZmaskNode;
		public var tile:ZmaskTile;
		public var atlasOp:ZatlasOp;
		public var key_ZmaskSprite:Dictionary=new Dictionary();
		
		public function load():void{
			var sp:Zshard=new Zshard(node);
			atlasOp=new ZatlasOp(node);
			atlasOp.data=tile.atlas;
			register();
			atlasOp.load(atlasLoaded);
		}
		
		public function register():void{
			var pos:Point;
			var frame:Zframe;
			var key:String;
			var zs:ZmaskSprite;
			
			for(var i:int=0;i<tile.atlas.frameList.length;i++){
				pos=tile.shardPosList[i];
				frame=tile.atlas.frameList[i];
				key=makeKey(tile,i);
//				trace("load key",key,this);
				
				zs=new ZmaskSprite(node);
				key_ZmaskSprite[key]=zs;
				
				zs.shard=new ZframeOp();
				zs.shard.subId=i.toString();
				zs.shard.sheet=atlasOp.sheetList[frame.idxSheet];
				zs.shard.sheet.usageType=ZsheetOp.Mask;
				zs.shard.alpha=0.65;
				zs.shard.boundingBox=frame.boundingBox;
				zs.shard.rectOnSheet=frame.rectOnSheet.clone();
				zs.shard.scale=FastMath.pow2x(tile.pyramid.zMax-tile.fi.z);
				zs.shard.driftX=(pos.x-frame.anchor.x)*zs.shard.scale;
				zs.shard.driftY=(pos.y-frame.anchor.y)*zs.shard.scale;
				zs.shard.depth=pos.y*zs.shard.scale;
			}
		}
		
		public function atlasLoaded(op:ZatlasOp):void{
			for(var i:int=0;i<tile.atlas.frameList.length;i++){
				var key:String=makeKey(tile,i);
//				trace("show key",key,this);
				var zs:ZmaskSprite=key_ZmaskSprite[key];
				zs.display(zs.shard);
			}
		}
		
		public function dispose():void{
//			atlasOp.clear();
			
			var pos:Point;
			var frame:Zframe;
			var key:String;
			var zs:ZmaskSprite;
			for(var i:int=0;i<tile.atlas.frameList.length;i++){
				pos=tile.shardPosList[i];
				frame=tile.atlas.frameList[i];
				
				key=makeKey(tile,i);
//				trace("out key",key,this);
				zs=key_ZmaskSprite[key] as ZmaskSprite;
				if(zs!=null){
					zs.dispose();
				}else{
					trace("sprite not found",this);
				}
				delete key_ZmaskSprite[key];
			}			
		}
		
		private function makeKey(tile:ZmaskTile,idxFrame:int):String{
			return tile.fi.fi+"_"+idxFrame;
		}
	}
}