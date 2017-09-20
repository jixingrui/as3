package azura.avalon.zbase.zway
{
	import azura.common.algorithm.FastMath;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	
	import flash.sampler.NewObjectSample;
	import flash.utils.Dictionary;
	
	public class BusMap implements BytesI
	{
		public var width:int;
		public var height:int;		
		public var groupList:Vector.<NodeGroup>=new Vector.<NodeGroup>();
		
//		public var nodeList:Vector.<WayDot45>=new Vector.<WayDot45>();
		private var xy_WayDot45:Dictionary=new Dictionary();
		
		public function xyToStation(xy:int):WayDot45{
			return xy_WayDot45[xy];
		}
				
		public function fromBytes(zb:ZintBuffer):void
		{
			var node:WayDot45;
			
			width=zb.readZint();
			height=zb.readZint();
			
			var numGroup:int=zb.readZint();
			trace("num group =",numGroup,this);
			for(var ig:int=0;ig<numGroup;ig++){
				var zbGroup:ZintBuffer=zb.readBytesZ();
				
				var wg:NodeGroup=new NodeGroup();
				groupList.push(wg);
				var size:int=zbGroup.readZint();
				for(var i:int=0;i<size;i++){
					node=new WayDot45();
					node.group=ig;
					node.fromBytes(zbGroup.readBytesZ());
					xy_WayDot45[node.xy]=node;
					wg.list.push(node);
				}
			}
			
			for each(node in xy_WayDot45){
				for each(var nid:int in node.neighborsId){
					var nn:WayDot45=xy_WayDot45[nid];
					node.neighbors.push(nn);
				}
				for each(nid in node.neighborsIdExt){
					nn=xy_WayDot45[nid];
					node.neighborsExt.push(nn);
				}
			}
			
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(width);
			zb.writeZint(height);
			zb.writeZint(groupList.length);
			for each(var wg:NodeGroup in groupList){
				var zbGroup:ZintBuffer=new ZintBuffer();
				zbGroup.writeZint(wg.list.length);
				for each(var wn:WayDot45 in wg.list){
					zbGroup.writeBytesZ(wn.toBytes());
				}
				zb.writeBytesZ(zbGroup);
			}
			return zb;
		}
		
	}
}