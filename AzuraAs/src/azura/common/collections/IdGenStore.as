package azura.common.collections {
	
	public class IdGenStore{
		
		private var idMax:int;
		private var recycle:Vector.<int>;
		private var store:Array;
		
		public function IdGenStore() {
			clear();
		}
		
		public function add(item:*):int {
			var id:int=0;
			if(recycle.length==0){
				id = idMax++;
				store.push(item);
			} else {
				id=recycle.shift();
				store[id]=item;
			}
			return id;
		}
		
		public function remove(id:int):* {
			if (id >= 0&& id <= idMax) {
				var result:*= store[id];
				store[id]=null;
				recycle.push(id);
				return result;
			}else{
				return null;
			}
		}
		
		public function get(id:int):*{
			if (id > 0&& id <= idMax) {
				return store[id];
			} else {
				return null;
			}
		}
		
		public function size():int{
			return store.length;
		}
		
		public function clear():void {
			recycle=new Vector.<int>();
			store=new Array();
			store.push(null);
			idMax=1;
		}
	}
}