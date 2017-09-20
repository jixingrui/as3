package azura.banshee.g2d.old
{
	import com.genome2d.node.GNode;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class Shine
	{
		private static var Shine_Shine:Dictionary=new Dictionary();
		
		public static function shine(target:GNode):void{
			var shine:Shine=new Shine(target);
			Shine_Shine[shine]=shine;
		}
		
		private var target:GNode;
		private var timer:Timer;
		private var delta:Number=0.05;
		public function Shine(target:GNode)
		{
			this.target=target;
			timer=new Timer(10,20);
			timer.addEventListener(TimerEvent.TIMER,onTick);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onDone);
			timer.start();
		}
		
		private function onTick(te:TimerEvent):void{
			if(target.transform.scaleX>1.5)
				delta=-delta;
			
			target.transform.scaleX+=delta;
			target.transform.scaleY+=delta;
		}
		
		private function onDone(te:TimerEvent):void{
			target.transform.color=0xffffff;
			target.transform.scaleX=1;
			target.transform.scaleY=1;
			target.transform.rotation=0;
			delete Shine_Shine[this];
		}
	}
}