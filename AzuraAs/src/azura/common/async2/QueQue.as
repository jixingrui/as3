package azura.common.async2
{
	import avmplus.getQualifiedClassName;
	
	public class QueQue
	{
		private var qq:Vector.<Que>=new Vector.<Que>();
		private var current:Que;
		internal var threads:int;
		
		public function QueQue(threads:int){
			this.threads=threads;
		}
		
		public function order(clazz:Class):QueQue{
			var name:String=getQualifiedClassName(clazz);
			this.threads=threads;
			//			trace(this,name);
			
			var config:LoaderConfig=Async2.clazz_config[clazz] as LoaderConfig;
			if(config!=null)
				throw new Error("Async2: can only order once");
			
			var q:Que=new Que(this);
			qq.push(q);
			
			config=new LoaderConfig();
			config.clazz=clazz;
			config.threads=threads;
			config.q=q;
			
			Async2.clazz_config[clazz]=config;
			
			return this;
		}
		
		public function workQQ():void{
			
			for each(current in qq){
				if(current.hasTask){
					current.workQ();
					return;
				}
			}
			
			if(isAllDone()){
				Async2.checkDone();
			}
		}
		
		public function isAllDone():Boolean{
			var isWorking:Boolean=false;
			for each(current in qq){
				if(current.isWorking){
					isWorking=true;
					break;					
				}
			}
			return !isWorking;
		}
	}
}