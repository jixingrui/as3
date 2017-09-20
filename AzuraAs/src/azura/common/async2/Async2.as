package azura.common.async2
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.osflash.signals.Signal;
	
	public class Async2
	{
		
		internal static var clazz_config:Dictionary=new Dictionary();
		
		private static var sequenceList:Vector.<QueQue>=new Vector.<QueQue>();
		
		public static var onAllDone:Signal=new Signal();
		
		public static function newSequence(threads:int=1):QueQue{
			var s:QueQue=new QueQue(threads);
			sequenceList.push(s);
			return s;
		}
		
		private static function getCreateConfig(clazz:Class):LoaderConfig{
			var config:LoaderConfig=clazz_config[clazz];
			if(config==null){
				config=new LoaderConfig();
				clazz_config[clazz]=config;
			}
			return config;
		}
		
		internal static function enque(loader:AsyncLoader2,key:*):void{
			var clazz:Class=getDefinitionByName(getQualifiedClassName(loader)) as Class;
			loader.config=clazz_config[clazz];
			if(loader.config==null){
				newSequence(1).order(clazz);
				loader.config=clazz_config[clazz];
			}
			loader.config.q.enque(loader,key);
			
		}
		
		public static function checkDone():void{
			var isWorking:Boolean=false;
			for each(var qq:QueQue in sequenceList){
				if(!qq.isAllDone()){
					isWorking=true;
					break;
				}
			}
			if(!isWorking){
//				trace("all done by Async2");
				onAllDone.dispatch();
			}
		}
	}
}