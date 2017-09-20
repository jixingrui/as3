package azura.common.util
{
	import flash.utils.Dictionary;
	
	public class Fork
	{
		private var dict:Dictionary=new Dictionary();
		private var ready_null:Function;
		
		public function Fork(ready_null:Function,...names)
		{
			this.ready_null=ready_null;
			for each(var name:String in names){
				dict[name]=false;
			}
		}
		
		public function ready(name:String):void{
			if(dict[name]!=null){
				dict[name]=true;
				check();
			}
		}
		
		public function notReady(name:String):void{
			dict[name]=false;
		}
		
		public function get isReady():Boolean{
			var allDone:Boolean=true;
			for (var name:String in dict){
				if(dict[name]==false){
					allDone=false;
					break;
				}
			}
			return allDone;
		}
		
		private function check():void{
			if(isReady){
				if(ready_null!=null)
					ready_null.call();
				ready_null=null;
			}
		}
	}
}