package azura.banshee.zebra.zcombo
{
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.ZebraNode;
	import azura.banshee.zebra.i.ZebraOpI;
	
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	
	public class ZcomboOp implements ZebraOpI
	{
		public var data:Zcombo;
		
		private var opList:Vector.<ZebraNode>;
		
//		private var timer:Timer;
		
		public function ZcomboOp(data:Zcombo,parent:ZebraNode)
		{
			this.data=data;
			
//			var isMotive:Boolean;
			
			opList=new Vector.<ZebraNode>(data.partList.length);
			for(var i:int=0;i<opList.length;i++){
				var z:Zebra=data.partList[i];
				
//				var item:ZebraPlate=new ZebraPlate();.
				
				var item:ZebraNode=new ZebraNode(parent);
				opList[i]=item;
				item.data=z;
				
//				if(z.branch is Zmotion){
//					var motion:Zmotion=z.branch as Zmotion;
//					item.isMotive=motion.isMotive;
//					if(item.isMotive)
//						isMotive=true;
//				}
			}
			
//			if(isMotive){
//				timer=new Timer(1000/12);
//				timer.addEventListener(TimerEvent.TIMER,onTick);
//				timer.start();
//			}
		}
		
//		private function onTick(event:TimerEvent):void{
//			for each(var part:ZebraPlate in opList){
//				if(part.isMotive){
//					part.plate.tick();
//				}
//			}
//		}
		
		public function set zUp(value:int):void
		{
			for each(var p:ZebraNode in opList){
//				p.plate.zUp=value;
			}
		}
		
		public function look(viewLocal:Rectangle):void
		{
			for each(var p:ZebraNode in opList){
				p.branchOnDisplay.look(viewLocal);
//				p.plate.look(viewLocal);
			}
		}
		
		public function set angle(angle:int):void
		{
			throw new Error("ZcomboOp: should not be here");
		}
		
		public function get angle():int
		{
			throw new Error("ZcomboOp: should not be here");
		}
		
		public function tick():void{
			
		}
		
		public function clear():void{
			for each(var p:ZebraNode in opList){
//				p.op.dispose();
				p.dispose();
			}
		}
		
		public function load(ret:Function):void{
			ret.call();
		}
		
//		public function get onLoaded():Signal{
//			return null;
//		}
	}
}