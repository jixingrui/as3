package azura.avalon.zbase.zway
{
	import azura.common.algorithm.FastMath;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	
	import flash.sampler.NewObjectSample;
	import flash.utils.Dictionary;
	import azura.avalon.zbase.kd.KDTree;
	
	public class CopyofBusMap implements BytesI
	{
		public var width:int;
		public var height:int;		
		public var groupList:Vector.<NodeGroup>=new Vector.<NodeGroup>();
		
		public var nodeList:Vector.<WayDot45>=new Vector.<WayDot45>();
		private var kdTree:KDTree=new KDTree();
		
		public function search(x:int,y:int,r:int=64):Vector.<WayDot45>{
			var near:Array=kdTree.queryRange(new Array(x-r,y-r),new Array(x+r,y+r));
			var result:Vector.<WayDot45>=new Vector.<WayDot45>();
			for each(var n:WayDot45 in near){
				result.push(n);
			}
			result.sort(sortByDist);
			function sortByDist(one:WayDot45,two:WayDot45):int{
				one.dist(x,y);
				two.dist(x,y);
				if(one.distCache>two.distCache)
					return 1;
				else if(one.distCache<two.distCache)
					return -1;
				else
					return 0;
			}
			for each(var nr:WayDot45 in near){
				nr.distCache=-1;
			}
			return result;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var node:WayDot45;
			var id_WayNode:Dictionary=new Dictionary();
			
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
					id_WayNode[node.xy]=node;
					wg.list.push(node);
				}
			}
			
			for each(node in id_WayNode){
				//				trace(node.neighborsIdSingleSide);
				for each(var nid:int in node.neighborsIdSingleSide){
					var nn:WayDot45=id_WayNode[nid];
					node.neighbors.push(nn);
					nn.neighbors.push(node);
				}
			}
			
			for each(node in id_WayNode){
				//				trace(node.neighbors.length);
				kdTree.insert(node,node.x,node.y);
				nodeList.push(node);
			}
			kdTree.balance();
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