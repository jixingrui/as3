package azura.banshee.mass.sdk
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;
	import azura.banshee.mass.view.MassTreeNV2;
	
	import flash.utils.Dictionary;
	
	public class MassSwitch2 implements MassSdkI2
	{
		protected var pathLocal:String;
		private var path_next:Dictionary=new Dictionary();
		
		public function MassSwitch2(pathLocal:String)
		{
			this.pathLocal=pathLocal;
		}
		
		public function register(next:MassSwitch2):void{
			if(path_next[next.pathLocal]!=null)
				throw new Error();
			path_next[next.pathLocal]=next;
		}
		
		public function chainAction(action:MassAction):Boolean
		{
			var path:String=action.host.path;
			if(!endWith(path,pathLocal)){
				throw new Error();
			}
			var processor:MassSwitch2=null;
			var next:MassSwitch2=this;
			while(next!=null){
				processor=next;
				next=next.match(path);
			}
			
			var processed:Boolean=processor.act(action);
			if(processed==false){
				var msgLong:String="[coder]"+action.stringMsg+"<from>"+action.host.path+
					"<target>"+action.targetPath+"<at>"+processor.pathLocal;
				trace(msgLong,this);
				trace("[coder]"+action.stringMsg);
			}
			return processed;
		}
		
		private function match(head:String):MassSwitch2{
			for(var p:String in path_next){
				if(endWith(head,p)){
					return path_next[p];
				}
			}
			return null;
		}
		
		private static function minus(target:String, by:String):String{
			return target.substr(0,target.length-by.length);
		}
		
		private static function beginWith(whole:String, head:String):Boolean{
			var trueHead:String=whole.substr(0,head.length);
			return trueHead==head;
		}
		
		private static function endWith(whole:String, tail:String):Boolean{
			var trueTail:String=whole.substr(whole.length-tail.length,whole.length);
			return trueTail==tail;
		}
		
		//=================== to override ================
		public function act(action:MassAction):Boolean{
			return false;
		}
		
	}
}