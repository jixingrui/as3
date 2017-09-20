package azura.avalon.maze.data
{
	import azura.banshee.door.DoorI;
	import azura.common.algorithm.pathfinding.astar2.AStarI;
	import azura.common.algorithm.pathfinding.astar2.AStarNode;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	
	[Bindable]
	public class Door extends Item implements DoorI,AStarI
	{
		public var stepList:Vector.<AStarI> =new Vector.<AStarI>();
		private var step_dist:Dictionary=new Dictionary();		
		private var node_:AStarNode;
		
		public var toDoorUid:String;
		public var toDoorName:String;
		
		public var toDoor:Door;
		
		public var fillNotify:Signal=new Signal();
		
		public function Door(){
			node_=new AStarNode(this);
		}
		
		public function link(to:AStarI):void{
			stepList.push(to);
			var dist:Number=RegionNode.FARDIST;
			var other:Door=to as Door;
			if(other!=null&&this.regionNode==other.regionNode){
				dist=AStarNode.manhattan_dist(this.x,this.y,other.x,other.y);	
			}
			this.step_dist[to]=dist;
		}
		
		public function get node():AStarNode{
			return node_;
		}
		
		public function get isWall():Boolean
		{
			return false;
		}
		
		public function estimateCost(far:AStarI):Number
		{
			var other:Door=far as Door;
			if(other!=null&&this.regionNode==other.regionNode){
				return AStarNode.manhattan_dist(this.x,this.y,other.x,other.y);	
			}else{
				return far.estimateCost(this);
			}
		}
		
		//ToDo: use walk path length
		public function stepCost(neighbor:AStarI):Number
		{
			var left:Door=this as Door;
			var right:Door=neighbor as Door;
			if(left!=null&&right!=null){
				return step_dist[neighbor];
			}else{
				return neighbor.stepCost(this);
			}
		}
		
		public function stepChoices():Vector.<AStarI>
		{
			return stepList;
		}
		
		override public function zboxTouched():Boolean
		{
			trace("click door",name,this);
			if(toDoorUid.length>0)
				EventCenter.enterDoor_String.dispatch(toDoorUid);
			return true;
		}
		
		public function enter(uid:String):void
		{
		}
		
		override public function fromBytes(zb:ZintBuffer):void
		{
			super.fromBytes(zb.readBytesZ());
			toDoorUid=zb.readUTF();
			toDoorName=zb.readUTF();
			
			fillNotify.dispatch();
		}
		
		override public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytesZ(super.toBytes());
			zb.writeUTF(toDoorUid);
			zb.writeUTF(toDoorName);
			return zb;
		}
		
		override public function clear():void
		{
			super.clear();
			toDoorUid='';
			toDoorName='';
			region=0;
		}
		
		override public function toString():String{
			return "[D]"+regionNode.room.data.name+"."+name;
		}
	}
}