package azura.expresso.rpc {
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	
	import flash.errors.IllegalOperationError;
	
	public class Rpc {
		
		public static var Single:int=0;
		public static var Bi_Call:int=1;
		public static var Bi_Return:int=2;
		
		public var type:int;
		public var session:int;
		public var service:int;
		public var ruler:int= -1;
		private var datum:Datum;
		private var node:RpcNodeA;
		
		public function Rpc(node:RpcNodeA) {
			this.node = node;
		}
		
		public function getDatumNoCheck():Datum {
			return datum;
		}
		
		public function setDatum(type:int, datum:Datum):void {
			this.datum = datum;
			if (datum.CLASSID() != type)
				throw new IllegalOperationError("rpc datum wrong type");
		}
		
		public function getDatum(type:int):Datum {
			if (datum.CLASSID() != type)
				throw new IllegalOperationError("rpc datum wrong type");
			return datum;
		}
		
		public function returnToRemote():void{
			node.returnToRemote(this);
		}
		
		public function encode():ZintBuffer {
			var zb:ZintBuffer= new ZintBuffer();
			zb.writeZint(type);
			zb.writeZint(session);
			zb.writeZint(service);
			if (datum == null) {
				zb.writeZint(-1);
			} else {
				zb.writeZint(datum.CLASSID());
				datum.writeTo(zb);
			}
			zb.position=0;
			return zb;
		}
		
		public function decode(zb:ZintBuffer):void {
			type=zb.readZint();
			session = zb.readZint();
			service = zb.readZint();
			var dataType:int= zb.readZint();
			if (dataType != -1) {
				datum = node.ns.newDatum(dataType);
				datum.readFrom(zb);
			}else{
				//				trace("Rpc without datum");
			}
		}
		
	}
}