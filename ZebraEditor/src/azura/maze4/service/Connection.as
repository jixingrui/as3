package azura.maze4.service
{
	import azura.common.collections.ZintBuffer;
	import azura.fractale.FrackConfigI;
	import azura.fractale.filter.FrackSocketA;
	import azura.karma.def.KarmaSpace;
	import azura.karma.hard11.HardItem;
	import azura.karma.hard11.service.HardUserI;
	import azura.karma.hard11.service.HubC_SC;
	
	import org.osflash.signals.Signal;

	public class Connection extends FrackSocketA implements HardUserI
	{
		public static var hub:HubC_SC;
		public static var ksHard:KarmaSpace;
		public static var ksMaze:KarmaSpace;
		
		public static var hubCreated:Signal=new Signal();
		public static var mazeCreated:Signal=new Signal();
		
		public var maze:MazeC_SC;
		
		public static var me:Connection;
		
		public function Connection(config:FrackConfigI) {
			super(config);
			onSocketReceive.addOnce(hardBoot);
			me=this;
		}		
		
		public function tunnelSend(zb:ZintBuffer):void
		{
//			trace("send",zb.length,this);
			super.sendToNet(zb);
		}
		
		private function hardBoot(zb:ZintBuffer):void{
			ksHard=new KarmaSpace();
			ksHard.fromBytes(zb);
			HardItem.ksHard=ksHard;
			hub=new HubC_SC(ksHard,this);
			onSocketReceive.add(hub.receive);
			
			hubCreated.dispatch();
		}
		
		public function receiveCustom(zb:ZintBuffer):void{
			if(maze==null){
				ksMaze=new KarmaSpace();
				ksMaze.fromBytes(zb);
				MazePack.ksMaze=ksMaze;
				maze=new MazeC_SC(ksMaze,hub);
				mazeCreated.dispatch();
			}else{
				maze.receive(zb);
			}
		}
		
		public function sendCustom(cargo:ZintBuffer):void{
			hub.sendCustom(cargo);
		}
	}
}