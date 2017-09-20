package azura.banshee.zbox3
{
	import azura.common.algorithm.FastMath;
	
	import mx.collections.Sort;
	
	import spark.globalization.SortingCollator;
	
	public class SortingTree extends NakedTree
	{
		
		/**
		 * larger covers smaller
		 * 
		 */
		public var sortValue:int=0;
		public var keepSorted:Boolean=false;
		
		
		public function SortingTree()
		{
			super();
		}
		
		public function get depthVector():Vector.<int>{
			var depth:Vector.<int>=new Vector.<int>();
			var pointer:SortingTree=this;
			while(pointer.parent_!=null){
				depth.unshift(pointer.myIdx);
				pointer=pointer.parent_ as SortingTree;
			}
			return depth;
		}
		
		private function get myIdx():int{
			var idx:int=parent_.childList.indexOf(this);
			if(idx==-1)
				throw new Error();
			return idx;
		}
		
		override public function addChild(child:NakedTree):void{
			super.addChild(child);
			
			if(keepSorted)
				sortOne(child as SortingTree);
		}
		
		public function sortOne(child:SortingTree):void{
			var idx:int=childList.indexOf(child);
			if(idx==-1)
				throw new Error();
			if(!checkPre(idx,child)){
				checkPost(idx,child);
			}
		}
		
		protected function checkSortMe():void{
			if(parent_==null)
				return;
			
			var p:SortingTree=parent_ as SortingTree;
			if(p.keepSorted){
				p.sortOne(this);
			}
		}
		
		private function checkPre(idx:int,target:SortingTree):Boolean{
			if(idx<=0)
				return false;
			
			var pre:SortingTree=childList[idx-1] as SortingTree;
			if(pre.sortValue>target.sortValue){
				swapChildren(idx-1,idx);
				checkPre(idx-1,target);
				return true;
			}
			return false;
		}
		
		private function checkPost(idx:int,target:SortingTree):Boolean{
			if(idx>=childList.length-1)
				return false;
			
			var post:SortingTree=childList[idx+1] as SortingTree;
			if(post.sortValue<target.sortValue){
				swapChildren(idx,idx+1);
				checkPost(idx+1,target);
				return true;
			}
			return false;
		}
		
		protected function swapChildren(one:int,two:int):void{
			//						trace("swap",one,two,this);
			var temp:SortingTree=childList[one] as SortingTree;
			childList[one]=childList[two];
			childList[two]=temp;
		}
		
		
	}
}