package azura.helios.drass9
{
	import azura.common.collections.ZintBuffer;
	import azura.helios.drass9.e.DrassCSE;
	import azura.helios.drass9.e.DrassSCE;
	import azura.helios.drass9.i.DrassCSI;
	import azura.helios.drass9.ui.Drass9;
	
	[Bindable]
	public class DrassClient implements DrassCSI
	{
		private var hub:DrassHub;
		public var ui:Drass9;
		
		public var upList:Vector.<DrassNode>=new Vector.<DrassNode>();
		public var downList:Vector.<DrassNode>=new Vector.<DrassNode>();
		public var hasPrev:Boolean=false;
		public var hasNext:Boolean=false;
		
		public function DrassClient(ui:Drass9,hub:DrassHub)
		{
			this.ui=ui;
			this.hub=hub;
		}
				
		public function receive(zb:ZintBuffer):void
		{
			var type:int=zb.readZint();
			if(type==DrassSCE.fillUp){
				upList=new Vector.<DrassNode>();
				var upSize:int=zb.readZint();
				for(var iu:int=0;iu<upSize;iu++){
					var nu:DrassNode=new DrassNode();
					nu.node=new Node();
					nu.node.fromBytes(zb.readBytesZ());
					nu.fromBytes(nu.node.data.clone());
					upList.push(nu);
				}
				ui.fillUp();
			}else if(type==DrassSCE.fillDown){
				hasPrev=zb.readBoolean();
				hasNext=zb.readBoolean();
				downList=new Vector.<DrassNode>();
				var downSize:int=zb.readZint();
				for(var id:int=0;id<downSize;id++){
					var nd:DrassNode=new DrassNode();
					nd.fromBytes(zb.readBytesZ());
//					nd.node=new Node();
//					nd.node.fromBytes(zb.readBytes_());
//					nd.fromBytes(nd.node.data.clone());
					downList.push(nd);
				}
				ui.fillDown();
			}else if(type==DrassSCE.clear){
//				upList=new Vector.<DrassNode>();
//				downList=new Vector.<DrassNode>();
//				ui.fillUp();
//				ui.fillDown();
				ui.clear();
			}else{
				throw new Error("drass message wrong format");
			}
		}
				
		public function delete_():void
		{
//			trace("delete");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.delete_);
			hub.send(zb,this);
		}
		
		public function rename(name:String):void
		{
//			trace("rename");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.rename);
			zb.writeUTF(name);
			hub.send(zb,this);
		}
		
		public function add(name:String):void
		{
//			trace("add");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.add);
			zb.writeUTF(name);
			hub.send(zb,this);
		}
		
		public function save(data:ZintBuffer):void
		{
//			trace("save");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.save);
			zb.writeBytesZ(data);
			hub.send(zb,this);
		}
		
		public function search(filter:String):void
		{
//			trace("search");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.search);
			zb.writeUTF(filter);
			hub.send(zb,this);
		}
		
		public function selectUp(idx:int):void
		{
//			trace("selectUp");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.selectUp);
			zb.writeZint(idx);
			hub.send(zb,this);
		}
		
		public function selectDown(idx:int):void
		{
//			trace("selectDown");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.selectDown);
			zb.writeZint(idx);
			hub.send(zb,this);
		}
		
		public function unselect():void
		{
//			trace("unselect");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.unselect);
			hub.send(zb,this);
		}
		
		public function capture():void
		{
//			trace("grab");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.capture);
			hub.send(zb,this);
		}
		
		public function drop():void
		{
//			trace("drop");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.drop);
			hub.send(zb,this);
		}
		
		public function pgSize(size:int):void
		{
//			trace("pgSize "+size);
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.pgSize);
			zb.writeZint(size);
			hub.send(zb,this);
		}
		
		public function pgUp():void
		{
//			trace("pgUp");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.pgUp);
			hub.send(zb,this);
		}
		
		public function pgDown():void
		{
//			trace("pgDown");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.pgDown);
			hub.send(zb,this);
		}
		
		public function jumpUp():void
		{
//			trace("jumpUp");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.jumpUp);
			hub.send(zb,this);
		}
		
		public function jumpDown():void
		{
//			trace("jumpDown");
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(DrassCSE.jumpDown);
			hub.send(zb,this);
		}
	}
}