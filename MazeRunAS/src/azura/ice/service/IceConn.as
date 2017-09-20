package azura.ice.service
{
	import azura.common.collections.ZintBuffer;
	import azura.fractale.FrackConfigI;
	import azura.fractale.filter.FrackSocketA;
	import azura.karma.def.KarmaSpace;
	
	import org.osflash.signals.Signal;
	
	public class IceConn extends FrackSocketA 
	{
		public static var ksIce:KarmaSpace;
		
		public var ice:IceC_SC;
		
		public static var me:IceConn;
		
		public var onIceReady:Signal=new Signal();
		
		public function IceConn(config:FrackConfigI) {
			super(config);
			onSocketReceive.addOnce(initKarma);
			me=this;
			//			super.connect();
		}		
		
		private function initKarma(zb:ZintBuffer):void{
			ksIce=new KarmaSpace();
			ksIce.fromBytes(zb);
			ice=new IceC_SC(ksIce,this);
			onSocketReceive.add(ice.receive);
			onIceReady.dispatch();
		}
		
	}
}