package azura.helios.hard10.hub
{
	import azura.common.collections.ZintBuffer;
	import azura.helios.hard10.ie.HardCSE;
	import azura.helios.hard10.ie.HardCsI;
	import azura.helios.hard10.ie.HardSCE;
	import azura.helios.hard10.ui.Hard10UI;
	
	[Bindable]
	public class HardCS implements HardCsI
	{
		private var hub:HardHub;
		public var ui:Hard10UI;
		public var id:int;
		
		public var upList:Vector.<HardItem>=new Vector.<HardItem>();
		public var downList:Vector.<HardItem>=new Vector.<HardItem>();
		
		public function HardCS(id:int,ui:Hard10UI,hub:HardHub)
		{
			this.id=id;
			this.ui=ui;
			this.hub=hub;
		}
		
		public function receive(zb:ZintBuffer):void
		{
			var type:int=zb.readZint();
			if(type==HardSCE.rename){
				var newName:String=zb.readUTFZ();
				ui.renameSC(newName);
			}else if(type==HardSCE.fillUp){
				upList=new Vector.<HardItem>();
				var upSize:int=zb.readZint();
				for(var iu:int=0;iu<upSize;iu++){
					var nu:HardItem=new HardItem();
					nu.fromBytes(zb.readBytesZ());
					upList.push(nu);
				}
				ui.fillUpSc(upList);
			}else if(type==HardSCE.appendDown){
				var more:Vector.<HardItem>=new Vector.<HardItem>();
				var hasNext:Boolean=zb.readBoolean();
				var downSize:int=zb.readZint();
				for(var id:int=0;id<downSize;id++){
					var nd:HardItem=new HardItem();
					nd.fromBytes(zb.readBytesZ());
					more.push(nd);
					downList.push(nd);
				}
				ui.appendDownSc(more);
			}else if(type==HardSCE.clear){
				ui.clearSc(zb.readBoolean());
			}else if(type==HardSCE.update){
				ui.update(zb.readBoolean(),zb.readZint(),new HardItem(zb.readBytesZ()));
			}else if(type==HardSCE.delete_){
				ui.deleteSc(zb.readBoolean(),zb.readZint());
			}else if(type==HardSCE.select){
				ui.selectSc(zb.readBoolean(),zb.readZint());
			}else{
				throw new Error("drass message wrong format");
			}
		}
		
		public function delete_():void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.delete_m);
			hub.send(id,zb);
		}
		
		public function rename(name:String):void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.rename_m);
			zb.writeUTFZ(name);
			hub.send(id,zb);
		}
		
		public function add(data:ZintBuffer):void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.add_m);
			zb.writeBytesZ(data);
			hub.send(id,zb);
		}
		
		public function save(data:ZintBuffer):void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.save_m);
			zb.writeBytesZ(data);
			hub.send(id,zb);
		}
		
		public function select(up_down:Boolean,idx:int):void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.select);
			zb.writeBoolean(up_down);
			zb.writeZint(idx);
			hub.send(id,zb);
		}
		
		public function unselect():void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.unselect);
			hub.send(id,zb);
		}
		
		public function hold():void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.hold);
			hub.send(id,zb);
		}
		
		public function drop():void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.drop);
			hub.send(id,zb);
		}
		
		public function jump():void{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.jump);
			hub.send(id,zb);
		}
		
		public function askMore(up_down:Boolean,pageSize:int):void
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(HardCSE.askMore);
			zb.writeBoolean(up_down);
			zb.writeZint(pageSize);
			hub.send(id,zb);
		}
		
	}
}