package azura.banshee.mass.sdk
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.v3.MassTree3;
//	import azura.common.ui.alert.Toast;
	
	import flash.utils.Dictionary;
	
	public class MassCoderA4
	{
		protected var path:String;
		private var childList:Vector.<MassCoderA4>=new Vector.<MassCoderA4>();
		private var _tree:MassTree3;
		public var debug:Boolean=true;
		
		public function MassCoderA4(path:String="")
		{
			this.path=path;
		}
		
		public function get tree():MassTree3
		{
			return _tree;
		}
		
		public function set tree(value:MassTree3):void
		{
			if(value==null)
				throw new Error();
			
			_tree = value;
			for each(var next:MassCoderA4 in childList){
				next.tree=value;
			}
		}
		
		public function register(next:MassCoderA4):void{
			childList.push(next);
		}
		
		public function pipe(mc:MassCoder):Boolean
		{
			var path:String=mc.from;
			if(!endWith(path,path)){
				throw new Error();
			}
			var processor:MassCoderA4=null;
			var next:MassCoderA4=this;
			while(next!=null){
				processor=next;
				next=next.match(path);
			}
			
			if(processor!=this){
				return processor.pipe(mc);
			}
			
			var token:String=path.substring(0,path.length-this.path.length);
			var done:Boolean=this.act(token,mc);
			if(done==false && debug==true){
				var msgLong:String=mc.toString()+"<at>"+processor.path;
				trace(msgLong,this);
				trace("[coder]"+mc.note);
			}
			return done;
		}
		
		private function match(head:String):MassCoderA4{
			for each(var c:MassCoderA4 in childList){
				if(endWith(head,c.path)){
					return c;
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
		public function act(token:String, mc:MassCoder):Boolean{
			trace("please override act()",this);
			return false;
		}
		
	}
}