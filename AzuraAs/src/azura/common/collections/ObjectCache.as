package azura.common.collections
{
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	
	public class ObjectCache
	{
		private var dic:Dictionary;
		private var strong:Object;
		private var timer:Timer;
		private var _delay:int=1;
		
		public function ObjectCache(){
			timer=new Timer(delay*1000,0);
			timer.addEventListener(TimerEvent.TIMER,tick,false,0,true);
		}
		
		private function get delay():int
		{
			return _delay;
		}
		
		private function set delay(value:int):void
		{
			value=Math.min(value,30);
			_delay = value;
			
			timer.delay=delay*1000;
		}
		
		public function put( value : *):void
		{					
			delay+=4;
			strong=value;
			putWeak(null);
			
			if(!timer.running){
				timer.start();
			}
		}
		
		public function getObj() : *
		{			
			var value:Object=getAny();
			
			if(value==null){
				timer.stop();
			}else{
				put(value);
			}
			return value;
		}	
		
		public function get isEmpty():Boolean{
			return getAny()==null;
		}
		
		private function getAny():Object{
			if(strong!=null)
				return strong;
			else
				return getWeak();
		}
		
		private function tick(event:TimerEvent):void{
			if(strong!=null){
				putWeak(strong);
				strong=null;
				
				timer.delay=delay/2;
			}else{
				var value:Object=getWeak();
				if(value!=null){
					put(value);
				}else{
					delay=1;
					timer.stop();
				}
			}
		}
		
		private function putWeak(value:Object):void{
			if(value==null){
				dic=null;
			}else{
				dic = new Dictionary( true );
				dic[value] = true;
			}
		}
		
		private function getWeak():Object{
			if(dic==null)
				return null;
			for ( var item:Object in dic )
			{
				return item;
			}
			return null;
		}
	}
}