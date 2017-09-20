package azura.banshee.mass.service
{
	import azura.banshee.mass.editor.MassPanel3;
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTree;
	import azura.banshee.mass.model.ScreenSetting;
	import azura.banshee.mass.model.v3.MassTree3;
	import azura.banshee.zbox3.Zbox3;
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	import azura.expresso.rpc.RpcTunnelI;
	import azura.gallerid4.Gal4Pack;
	import azura.helios.hard10.hub.HardHub;
	import azura.phoenix12.drop.zui.param.Arg1073Hint;
	import azura.phoenix12.drop.zui.param.Arg1077Hint;
	import azura.phoenix12.drop.zui.param.Arg1085Hint;
	import azura.phoenix12.drop.zui.param.Arg1098Hint;
	import azura.phoenix12.drop.zui.param.Arg1102Hint;
	import azura.phoenix12.drop.zui.param.Arg1106Hint;
	import azura.phoenix12.drop.zui.param.Arg1121Hint;
	import azura.phoenix12.drop.zui.param.Arg1133Hint;
	import azura.phoenix12.drop.zui.param.Arg1149Hint;
	import azura.phoenix12.drop.zui.param.Ret1082Hint;
	import azura.phoenix12.drop.zui.param.Ret1096Hint;
	import azura.phoenix12.drop.zui.param.Ret1126Hint;
	import azura.phoenix12.drop.zui.service.zuiCSA;
	import azura.phoenix12.drop.zui.service.zuiCSI;
	
	public class ZuiCS extends zuiCSA implements zuiCSI, RpcTunnelI
	{
		public var hub:HardHub;
				
		public function ZuiCS(tunnel:RpcTunnelI)
		{
			super(ZuiEditNet.nsZui, tunnel, this);
			hub=new HardHub(this);
		}
		
		public function hardHandler(arg1077:Datum):void
		{
			var msg:ZintBuffer=arg1077.getBean(Arg1077Hint.msg).asBytes();
			hub.receive(msg);
		}
		
		public function changeByAction(idx:int):void{
			var arg1098:Datum=ns.newDatum(Arg1098Hint.CLASS);
			arg1098.getBean(Arg1098Hint.type).setInt(idx);
			selectByActionCall(arg1098);
		}
		
		public function changeToAction(idx:int):void{
			var arg1133:Datum=ns.newDatum(Arg1133Hint.CLASS);
			arg1133.getBean(Arg1133Hint.type).setInt(idx);
			selectToActionCall(arg1133);
		}
		
		public function setTarget():void{
			setTargetCall();
		}
				
		public function tellActionHandler(arg1102:Datum):void
		{
			var data:ZintBuffer=arg1102.getBean(Arg1102Hint.action).asBytes();
			MassPanel3.instance.tellAction(data);
		}
		
		public function saveMsg(action:MassAction):void{
			var zb:ZintBuffer=action.toBytes();
			var arg1106:Datum=ns.newDatum(Arg1106Hint.CLASS);
			arg1106.getBean(Arg1106Hint.action).setBytes(zb);
			saveMsgCall(arg1106);
		}
		
		public function save(call_Gal4Pack:Function,helper:Zbox3):void{
			saveCall(ret);
			function ret(ret1082:Datum):void{
				var dump:ZintBuffer=ret1082.getBean(Ret1082Hint.dump).asBytes();
				var tree:MassTree3=new MassTree3(helper,null);
				tree.fromBytes(dump);
				var gp:Gal4Pack=new Gal4Pack();
				gp.setMaster(dump);
				
				var slaveList:Vector.<String>=new Vector.<String>();
				tree.getMc5List(slaveList);
				gp.addSlaveList(slaveList);
				
				tree.dispose();
				
				call_Gal4Pack.call(null,gp);
				//				call_ZintBuffer.call(null,gp.toBytes());
			}
		}
		
		public function load(data:ZintBuffer):void{
			var arg1085:Datum=ns.newDatum(Arg1085Hint.CLASS);
			arg1085.getBean(Arg1085Hint.dump).setBytes(data);
			loadCall(arg1085);
		}
		
		public function report(report_ByteArray:Function):void{
			super.reportActionCall(call_ret1096);
			function call_ret1096(ret1096:Datum):void{
				var zb:ZintBuffer=ret1096.getBean(Ret1096Hint.report).asBytes();
				zb.uncompress();
				report_ByteArray.call(null,zb);
			}
		}
		
		public function wipe():void{
			wipeCall();
		}
		
		public function setScreenSetting(ss:ScreenSetting):void{
			var arg1121:Datum=ns.newDatum(Arg1121Hint.CLASS);
			arg1121.getBean(Arg1121Hint.data).setBytes(ss.toBytes());
			setScreenSettingCall(arg1121);
		}
		
		public function getScreenSetting(ret_SS:Function):void{
			getScreenSettingCall(ret_Remote);
			function ret_Remote(ret1126:Datum):void{
				var data:ZintBuffer=ret1126.getBean(Ret1126Hint.data).asBytes();
				var ss:ScreenSetting=new ScreenSetting();
				ss.fromBytes(data);
				ret_SS.call(null,ss);
			}			
		}
		
		public function tellScreenSettingHandler(arg1149:Datum):void{
			var data:ZintBuffer=arg1149.getBean(Arg1149Hint.data).asBytes();
			var ss:ScreenSetting=new ScreenSetting();
			ss.fromBytes(data);
			MassPanel3.instance.resizeScreen(ss.designWidth,ss.designHeight);
		}
		
		public function connected():void
		{
		}
		
		public function disconnected():void
		{
		}
		
		public function tunnelSend(zb:ZintBuffer):void
		{
			var arg1073:Datum=ns.newDatum(Arg1073Hint.CLASS);
			arg1073.getBean(Arg1073Hint.msg).setBytes(zb);
			hardCall(arg1073);
		}
	}
}