package azura.fractale.filter
{
	import azura.common.collections.ZintBuffer;
	import azura.common.data.OutI;
	import azura.fractale.FrackConfigI;
	
	import flash.system.Security;
	
	import org.osflash.signals.Signal;
	
	public class FrackSocketA implements OutI
	{
		private var config:FrackConfigI;
		private var crossdomain:int;
		
		private var fl:FrackeyLayer;
		
		public var onConnected:Signal=new Signal();
		public var onDisconnected:Signal=new Signal();
		public var onSocketError:Signal=new Signal();
		public var onSocketReceive:Signal=new Signal(ZintBuffer);
		
		private var pool:Vector.<ZintBuffer>=new Vector.<ZintBuffer>();
		
		public function FrackSocketA(config:FrackConfigI, crossdomain:int=8843){
			this.config=config;
			this.crossdomain=crossdomain;
			fl=new FrackeyLayer(this);
		}
		
		public function connect():void{
			
			if(config.port==crossdomain)
				throw new Error("FrackSocketA: "+crossdomain+" is reserved");
			
			Security.loadPolicyFile("xmlsocket://"+ config.host +":"+crossdomain);
			
			fl.connect(config);
		}
		
		public function close():void{
			trace("socket closed",this);
			fl.close();
		}
		
		internal function connected():void{
			trace("connected",this);
			
			while(pool.length>0){
				var zb:ZintBuffer=pool.shift();
				fl.sendToNet(zb);
			}
			
			onConnected.dispatch();
		}
		
		public function sendToNet(zb:ZintBuffer):void{
			if(fl.isConnected){
				fl.sendToNet(zb);
			}else{
				trace("socket not ready",this);
				pool.push(zb.clone());
				if(!fl.isConnecting)
					connect();
			}
		}
		
		public function out(zb:ZintBuffer):void{
			sendToNet(zb);
		}
	}
}