package azura.expresso {
	import flash.utils.Dictionary;
	
	public class Family {
		
		private var parent_ChildSet:Dictionary=new Dictionary();
		private var child_ParentSet:Dictionary=new Dictionary();
		
		public function link(parent:int, child:int):void {
			getChildSet(parent).push(child);
			getParentSet(child).push(parent);
		}
		
		public function getChildSet(parent:int):Vector.<int> {
			var s:Vector.<int> = parent_ChildSet[parent];
			if (s == null) {
				s = new Vector.<int>();
				parent_ChildSet[parent]= s;
			}
			return s;
		}
		
		public function getParentSet(child:int):Vector.<int> {
			var s:Vector.<int> = child_ParentSet[child];
			if (s == null) {
				s = new Vector.<int>();
				child_ParentSet[child]= s;
			}
			return s;
		}
		
		public function getAncestorAndSelf(id:int):Vector.<int> {
			var finishSet:Vector.<int> = new Vector.<int>();
			var unfinish:Vector.<int> = new Vector.<int>();
			unfinish.push(id);
			while (unfinish.length > 0) {
				var current:int= unfinish.pop();
				finishSet.push(current);
				for each (var parent:int in getParentSet(current)) {
					if (finishSet.indexOf(parent)==-1) {
						unfinish.push(parent);
					}
				}
			}
			return finishSet;
		}
		
		public function getDescendentAndSelf(id:int):Vector.<int> {
			var finishSet:Vector.<int> = new Vector.<int>();
			var unfinish:Vector.<int> = new Vector.<int>();
			unfinish.push(id);
			while (unfinish.length > 0) {
				var current:int= unfinish.pop();
				finishSet.push(current);
				for each (var child:int in getChildSet(current)) {
					if (finishSet.indexOf(child)==-1) {
						unfinish.push(child);
					}
				}
			}
			return finishSet;
		}
		
	}
}