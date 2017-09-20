package azura.avalon.fi.view
{
	import azura.common.algorithm.FoldIndex;
	import azura.common.collections.DictionaryUtil;
	
	import flash.utils.Dictionary;
	
	public class FiSet
	{
		private var dict:Dictionary=new Dictionary();
		
		/**
		 * 
		 * @return ordered by z
		 * 
		 */
		public function getList():Vector.<FoldIndex>{
			var result:Vector.<FoldIndex>=new Vector.<FoldIndex>();
			for each(var fi:FoldIndex in dict){
				result.push(fi);
			}
			result.sort(compareFunction);
			return result;
		}
		
		public function get size():int{
			return DictionaryUtil.getLength(dict);
		}
		
		public function compareFunction(one:FoldIndex,two:FoldIndex):int{
			if(one.fi>two.fi)
				return 1;
			else if(one.fi<two.fi)
				return -1;
			else 
				return 0;
		}
		
		public function put(fi:FoldIndex):void{
			dict[fi.fi]=fi;
		}
		
		public function putAll(more:FiSet):void{
			for each(var item:FoldIndex in more.dict) {
				put(item);
			}
		}
		
		public function remove(fi:FoldIndex):void{
			delete dict[fi.fi];
		}
		
		public function contains(fi:FoldIndex):Boolean{
			return dict[fi.fi]!=null;
		}
		
		public function andNot(filter:FiSet):FiSet{
			var result:FiSet=new FiSet();
			for each(var fi:FoldIndex in dict){
				if(!filter.contains(fi)){
					result.put(fi);
				}
			}
			return result;
		}
		
		public function clone():FiSet{
			var result:FiSet=new FiSet();
			for each(var fi:FoldIndex in this.dict){
				result.put(fi);
			}
			return result;
		}
	}
}