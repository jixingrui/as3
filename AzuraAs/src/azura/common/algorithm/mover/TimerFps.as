package azura.common.algorithm.mover
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import org.osflash.signals.Signal;
	
	public class TimerFps
	{
		private static var fps_Timer:Dictionary=new Dictionary();
		private static var User_Timer:Dictionary=new Dictionary();
		
		public static function tick():void{
			
			var time:int=getTimer();
			
			FPS.tick(time);
			
			for each(var tf:TimerLevel in fps_Timer){
				tf.tick(time);
			}
		}
		
		public static function setTimer(fps:Number, user:TimerI):void{
			if(fps<1)
				fps=1;
			else if(fps>60)
				fps=60;
			
			removeTimer(user);
			var tf:TimerLevel=fps_Timer[fps];
			if(tf==null){
				tf=new TimerLevel(fps);
				fps_Timer[fps]=tf;
			}
			tf.add(user);
			User_Timer[user]=tf;
		}
		
		public static function removeTimer(user:TimerI):void{
			var tf:TimerLevel=User_Timer[user];
			if(tf!=null){
				tf.remove(user);
				delete User_Timer[user];
			}
		}
	}
}