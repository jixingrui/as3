package azura.zombie.service
{
	import azura.common.collections.ZintBuffer;
	import azura.fractale.FrackConfigI;
	import azura.fractale.filter.FrackSocketA;
	import azura.karma.def.KarmaSpace;
	
	import org.osflash.signals.Signal;
	
	public class ZombieConn extends FrackSocketA 
	{
		public static var ksZombie:KarmaSpace;
		
		public var zombie:ZombieC_SC;
		
		public static var me:ZombieConn;
		
		public var onZombieReady:Signal=new Signal();
		
		public function ZombieConn(config:FrackConfigI) {
			super(config);
			onSocketReceive.addOnce(initKarma);
			me=this;
			super.connect();
		}		
		
		private function initKarma(zb:ZintBuffer):void{
//			trace("socket receive",zb.length,"bytes",this);
			ksZombie=new KarmaSpace();
			ksZombie.fromBytes(zb);
			zombie=new ZombieC_SC(ksZombie,this);
			onSocketReceive.add(zombie.receive);
			onZombieReady.dispatch();
		}
		
	}
}