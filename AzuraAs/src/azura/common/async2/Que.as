package azura.common.async2
{
	import flash.utils.Dictionary;
	
	public class Que{
		
		private var qq:QueQue;
		
		private var running:int;
		private var workOnceList:Array=new Array();
		private var key_KV:Dictionary=new Dictionary();
		
		public function Que(qq:QueQue){
			this.qq=qq;
		}
		
		internal function enque(loader:AsyncLoader2,key:*):void{
			var kv:KV=key_KV[key];
			if(kv==null){
				kv=new KV(this);
				kv.key=key;
				key_KV[key]=kv;
			}
			loader.kv=kv;
		}
		
		internal function load(kv:KV):void{
			workOnceList.push(kv);
			qq.workQQ();
		}
		
		internal function get hasTask():Boolean{
			return workOnceList.length>0;
		}
		internal function get isWorking():Boolean{
			return running>0;
		}
		
		internal function remove(kv:KV):void{
			delete key_KV[kv.key];
			var idx:int=workOnceList.indexOf(kv);
			if(idx!=-1)
				workOnceList.splice(idx,1);
		}
		
		internal function workQ():void{
			if(running<qq.threads){
				var kv:KV=workOnceList.shift();
				if(kv==null){
					qq.workQQ();					
				}else {
					running++;
					kv.workKV();
					workQ();
				}
			}
		}
		
		internal function workDone():void{
			running--;
			qq.workQQ();
		}
	}
}