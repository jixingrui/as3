package azura.banshee.zbox3.zebra.zmask
{
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	
	public class ZmaskTile2Op
	{
		public var host:ZmaskC3;
		public var tile:ZmaskTile2;
		public var key_ZshardC3:Dictionary=new Dictionary();
		
		public function load():void{
//			var sp:ZshardC3=new ZshardC3(host.zbox);

			var pos:Point;
			var frame:Zframe2;
			var key:String;
			var zs:ZshardC3;
			
//			var dz:int=tile.pyramid.zMax-tile.fi.z;
//			var ds:Number=FastMath.pow2(dz);
//			var shift:Number=FoldIndex.sideLength(tile.pyramid.zMax)/2*512/ds-256;
//			var dx:int=tile.x*512/2-shift;
//			var dy:int=tile.y*512/2-shift;
			
			for(var i:int=0;i<tile.atlas.frameList.length;i++){
				pos=tile.shardPosList[i];
				frame=tile.atlas.frameList[i];
				key=makeKey(tile,i);
//				trace("load key",key,this);
				
				zs=new ZshardC3(host.zbox);
				key_ZshardC3[key]=zs;
				
//				zs.zbox.sortValue=pos.y;
//				zs.zbox.scaleLocal=ds;
//				zs.zbox.move(dx,dy);
				
				zs.subId=i.toString();
				zs.sheet=tile.atlas.sheetList[frame.idxSheet];
				zs.alpha=0.65;
				zs.boundingBox=frame.boundingBox;
				zs.rectOnSheet=frame.rectOnSheet.clone();
				zs.scale=FastMath.pow2x(tile.pyramid.zMax-tile.fi.z);
				zs.driftX=(pos.x-frame.anchor.x)*zs.scale;
				zs.driftY=(pos.y-frame.anchor.y)*zs.scale;
				zs.depth=pos.y*zs.scale;
				
				zs.display(frame);
			}
		}
		
//		public function atlasLoaded(op:ZatlasOp):void{
//			for(var i:int=0;i<tile.atlas.frameList.length;i++){
//				var key:String=makeKey(tile,i);
////				trace("show key",key,this);
//				var zs:ZshardC3=key_ZshardC3[key];
////				zs.display(zs.);
//			}
//		}
		
		public function dispose():void{
//			atlas.clear();
			
			var pos:Point;
			var frame:Zframe2;
			var key:String;
			var zs:ZshardC3;
			for(var i:int=0;i<tile.atlas.frameList.length;i++){
				pos=tile.shardPosList[i];
				frame=tile.atlas.frameList[i];
				
				key=makeKey(tile,i);
//				trace("out key",key,this);
				zs=key_ZshardC3[key] as ZshardC3;
				if(zs!=null){
					zs.zbox.dispose();
				}else{
					trace("sprite not found",this);
				}
				delete key_ZshardC3[key];
			}			
		}
		
		private function makeKey(tile:ZmaskTile2,idxFrame:int):String{
			return tile.fi.fi+"_"+idxFrame;
		}
	}
}