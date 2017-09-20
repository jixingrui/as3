package azura.banshee.zebra.box
{
	import azura.common.algorithm.aabb.AABBTree;
	
	public class AbBoxRoot extends AbBox
	{
		internal var tree:AABBTree=new AABBTree();
		
		public function AbBoxRoot()
		{
			super(null);
		}
		
		/**
		 * 
		 * @return someone responded
		 * 
		 */
		public function touch(x:int,y:int):Boolean{
			var found:Vector.<AABBI>=null;//tree.queryPoint(x,y);
			found.sort(byOrder);
			var someoneResponded:Boolean=false;
			for each(var target:AbBox in found){
				someoneResponded=target.observer.zboxTouched();
				if(someoneResponded)
					break;
			}
			return someoneResponded;
		}
		
		private function byOrder(one:AbBox,two:AbBox):int{
			if(one.observer.priority>two.observer.priority)
				return 1;
			else if(one.observer.priority<two.observer.priority)
				return -1;
			else if(one.yRoot>two.yRoot)
				return 1;
			else if(one.yRoot<two.yRoot)
				return -1;
			else
				return 0;
		}
	}
}