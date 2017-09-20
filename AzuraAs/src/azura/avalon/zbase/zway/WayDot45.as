package azura.avalon.zbase.zway
{
	import azura.avalon.zbase.bus.Pack16;
	import azura.common.algorithm.pathfinding.astar3.AStarI3;
	import azura.common.algorithm.pathfinding.astar3.AStarNode3;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	
	public class WayDot45 implements BytesI,AStarI3
	{
		public var xy:int;
		public var x:int;
		public var y:int;
		public var space:int;
		public var type:int;
		public var vital:Boolean;
		public var group:int;
		public var neighbors:Vector.<WayDot45>=new Vector.<WayDot45>();
		public var neighborsExt:Vector.<AStarI3> =new Vector.<AStarI3>();
		
		//cache
		public var neighborsId:Vector.<int>=new Vector.<int>();
		public var neighborsIdExt:Vector.<int>=new Vector.<int>();
		private var node_:AStarNode3;
		
		public function get point():Point{
			return new Point(x,y);
		}
		
		public function set node(n:AStarNode3):void{
			this.node_=n;
		}
		
		public function get node():AStarNode3{
			return node_;
		}
		
		public function toString():String{
			return "xy="+xy+",x="+x+",y="+y;
		}
		
		public function estimateCostFar(far:AStarI3):Number
		{
			var other:WayDot45=far as WayDot45;
			return iso_dist(x,y,other.x,other.y);
			//			return iso_dist(x,y,other.x,other.y)*2;
			//			return Math.sqrt((x-other.x)*(x-other.x)+(y-other.y)*(y-other.y)*2);
			//			return FastMath.dist(x,y,other.x,other.y);
			//			var expand:int=(other.space>this.space)?(other.space-this.space):0;
			//			return 0;
		}
		
		public function stepCostNear(neighbor:AStarI3):Number
		{
			var other:WayDot45=neighbor as WayDot45;
//			return Math.sqrt((x-other.x)*(x-other.x)+(y-other.y)*(y-other.y)*2);
			//			var expand:int=(other.space>this.space)?(other.space-this.space):0;
			//			return diagnal_dist(x,y,other.x,other.y);
						return iso_dist(x,y,other.x,other.y);
			//			return FastMath.dist(x,y,other.x,other.y);
		}
		
		public static function manhattan_dist( xs:int,ys:int,xe:int,ye:int ) : Number{
			var dx : uint = Math.abs( xe-xs );
			var dy : uint = Math.abs( ye-ys );
			return dx + dy;
		}
		
		public static function diagnal_dist( xs:int,ys:int,xe:int,ye:int  ) : Number{
			var dx : uint = Math.abs( xe-xs );
			var dy : uint = Math.abs( ye-ys );
			return (dx>dy)?(dx+0.4*dy):(dy+0.4*dx);
		}
		
		public static function iso_dist( xs:int,ys:int,xe:int,ye:int  ) : Number{
			var dx : uint = Math.abs( xe-xs );
			var dy : uint = Math.abs( ye-ys );
			return (dx>dy)?(dx+0.57*dy):(1.4*dy+0.4*dx);
		}
		
		public function stepChoices():Vector.<AStarI3>
		{
			return neighborsExt;
		}
		
		
		public function fromBytes(zb:ZintBuffer):void
		{
			x=zb.readZint();
			y=zb.readZint();
			xy=Pack16.pack(x,y);
			space=zb.readZint();
			type=zb.readZint();
			vital=zb.readBoolean();
			var nSize:int=zb.readZint();
			for(var i:int=0;i<nSize;i++){
				neighborsId.push(zb.readInt());
			}
			nSize=zb.readZint();
			for(i=0;i<nSize;i++){
				neighborsIdExt.push(zb.readInt());
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(x);
			zb.writeZint(y);
			zb.writeZint(space);
			zb.writeZint(type);
			zb.writeBoolean(vital);
			zb.writeZint(neighborsId.length);
			for each(var i:int in neighborsId){
				zb.writeInt(i);
			}
			zb.writeZint(neighborsIdExt.length);
			for each(var j:int in neighborsIdExt){
				zb.writeInt(j);
			}
			return zb;
		}
	}
}