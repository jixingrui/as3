package azura.banshee.zebra.node
{
	import azura.banshee.zebra.Zcombo;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.i.ZebraBranchI;
	import azura.banshee.zebra.i.ZebraI;
	import azura.banshee.zebra.zode.Znode;
	
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	
	public class ZcomboNodeOld extends Znode implements ZebraBranchI
	{
		private var _data:Zcombo;
		
		private var opList:Vector.<ZebraNode>;
		
		public function ZcomboNodeOld(parent:ZebraNode,data:Zebra)
		{
			super(parent);
			load(data);
		}
		
		public function get data():ZebraI
		{
			return _data;
		}

		public function load(value:Zebra=null):void
		{
			_data = value.branch as Zcombo;
			opList=new Vector.<ZebraNode>(_data.partList.length);
			for(var i:int=0;i<opList.length;i++){
				var z:Zebra=_data.partList[i];
				
				var item:ZebraNode=new ZebraNode(this);
				opList[i]=item;
				item.zebra=z;
			}
		}

		public function get boundingBox():Rectangle{
			return new Rectangle();
		}
		
		public function set zUp(value:int):void
		{
		}
		
		public function look(viewLocal:Rectangle):void
		{
		}
		
		public function set angle(angle:Number):void
		{
		}
		public function get angle():Number
		{
			return 0;
		}
		
//		public function get angle():Number
//		{
//			return -1;
//		}
		
		public function load2(ret:Function):void{
			ret.call();
		}
		
	}
}