package azura.karma.service
{
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.helios.hard10.hub.HardHub;
	import azura.karma.editor.KarmaPanel;
	import azura.phoenix12.drop.karma.param.Arg1155Hint;
	import azura.phoenix12.drop.karma.param.Arg1159Hint;
	import azura.phoenix12.drop.karma.param.Arg1167Hint;
	import azura.phoenix12.drop.karma.param.Arg1185Hint;
	import azura.phoenix12.drop.karma.param.Ret1164Hint;
	import azura.phoenix12.drop.karma.param.Ret1175Hint;
	import azura.phoenix12.drop.karma.param.Ret1179Hint;
	import azura.phoenix12.drop.karma.service.editCSA;
	import azura.phoenix12.drop.karma.service.editCSI;
	
	public class KarmaCS extends editCSA implements editCSI, RpcTunnelI
	{
		public var hub:HardHub;
		
		public function KarmaCS(tunnel:RpcTunnelI)
		{
			super(KarmaNet.nsKarma, tunnel, this);
			hub=new HardHub(this);
		}
				
		public function hardHandler(arg1159:Datum):void
		{
			var msg:ZintBuffer=arg1159.getBean(Arg1159Hint.msg).asBytes();
			hub.receive(msg);
		}
		
		public function selectedIsHandler(arg1185:Datum):void{
			var selectedName:String=arg1185.getBean(Arg1185Hint.name).asString();
			KarmaPanel.this_.btnSelected.label=selectedName;
			KarmaPanel.this_.hasFocus=true;
		}
		
		public function wipe():void{
			wipeCall();
		}
		
		public function select():void{
			selectCall();
		}
		
		public function addFork():void{
//			addForkCall();
		}
		
		public function save(ret:Function):void{
			saveCall(ret_fun);
			function ret_fun(r1164:Datum):void{
				var data:ZintBuffer=r1164.getBean(Ret1164Hint.pack).asBytes();
				ret.call(null,data);
			}
		}
		
		public function load(data:ZintBuffer):void{
			var arg1167:Datum=ns.newDatum(Arg1167Hint.CLASS);
			arg1167.getBean(Arg1167Hint.pack).setBytes(data);
			loadCall(arg1167);
		}
		
		public function java(ret:Function):void{
			javaCall(ret_fun);
			function ret_fun(r1175:Datum):void{
				var data:ZintBuffer=r1175.getBean(Ret1175Hint.pack).asBytes();
				ret.call(null,data);
			}
		}
		
		public function as3(ret:Function):void{
			as3Call(ret_fun);
			function ret_fun(r1179:Datum):void{
				var data:ZintBuffer=r1179.getBean(Ret1179Hint.pack).asBytes();
				ret.call(null,data);
			}
		}
		
		public function connected():void
		{
		}
		
		public function disconnected():void
		{
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg1155:Datum=ns.newDatum(Arg1155Hint.CLASS);
			arg1155.getBean(Arg1155Hint.msg).setBytes(zb);
			hardCall(arg1155);
		}
	}
}