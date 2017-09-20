package azura.fractale.filter
{
	import azura.common.collections.ZintBuffer;
	import azura.fractale.FrackConfigI;
	
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import org.osflash.signals.Signal;
	
	public class CopyofFrackSocketA
	{
		private var fl:FrackeyLayer;
		internal var zl:ZintLayer;
		
		private var _onConnected:Signal=new Signal();
		private var _onDisconnected:Signal=new Signal();
		private var _onSocketReceive:Signal=new Signal(ZintBuffer);
		
		public function get onSocketReceive():Signal
		{
			return _onSocketReceive;
		}

		public function get onDisconnected():Signal
		{
			return _onDisconnected;
		}

		public function get onConnected():Signal
		{
			return _onConnected;
		}
		
		public function sendToNet(zb:ZintBuffer):void{
			zl.sendToNet(zb);
		}

		public function connect(config:FrackConfigI):void{
			if(fl!=null)
				throw new Error("FrackSocketA: can only connect once");
			if(config.port==8843)
				throw new Error("FrackSocketA: 8843 is reserved");
			
			Security.loadPolicyFile("xmlsocket://"+ config.host +":8843");
			
			fl=new FrackeyLayer(config.frackey);
//			zl=new ZintLayer(this);
//			fl.zl=zl;
//			zl.fl=fl;
			
			fl.socket.connect(config.host,config.port);
		}
		
		public function close():void{
			trace("socket closed");
			fl.socket.close();
			fl.zl=null;
			zl.fl=null;
			fl=null;
			zl=null;
			onDisconnected.dispatch();
		}
		
	}
}