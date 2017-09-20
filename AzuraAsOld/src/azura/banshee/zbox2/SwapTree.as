package azura.banshee.zbox2
{
	public class SwapTree
	{
		protected var parent:SwapTree;
		protected var childList:Vector.<SwapTree>=new Vector.<SwapTree>();
		
		public var keepSorted:Boolean=false;
		
		private var delayedSwapper:Boolean=false;
		private var isActive:Boolean=false;
		
		private var iAmNewbie:Boolean=false;
		private var superIsNewbie:Boolean=false;
		
		protected var idle_loading_loaded:int=0;
		private var meOrChildrenLoading:Boolean=false;
		
		public function SwapTree(delayedSwapper:Boolean=false)
		{
			this.delayedSwapper=delayedSwapper;
		}
		
		//================= loading ==================
		public function notifyLocalLoadingStart():void{
			idle_loading_loaded=1;
			loadingBubbleUp();
		}
		
		public function notifyLocalLoadingFinish():void{
			if(this.idle_loading_loaded==0)
				throw new Error();
			
			this.idle_loading_loaded=2;
			
			
			loadedBubbleUp();
		}
		
		//=================== bubble =================
		private function loadingBubbleUp():void{
			if(meOrChildrenLoading)
				return;
			
			meOrChildrenLoading=true;
			if(parent!=null){
				parent.loadingBubbleUp();
			}
		}
		
		private function loadedBubbleUp():void{
			if(isRoot)
				return;
			if(!meOrChildrenLoading)
				return;
			
			meOrChildrenLoading=checkBelowLoading();
			
			if(!meOrChildrenLoading){
				if(iAmNewbie){
					iAmNewbie=false;
					notNewbieBubbleDown();
					if(this.delayedSwapper && !this.isActive){
						parent.removeActiveState();
						this.isActive=true;
						swapOn();
					}
				}
				if(superIsNewbie){
					parent.loadedBubbleUp();
				}
			}
		}
		
		private function notNewbieBubbleDown():void{
			for each(var child:SwapTree in childList){
				child.superIsNewbie=false;
				child.notNewbieBubbleDown();
			}
		}
		
		//==================== sort ===============
		/**
		 * larger covers smaller
		 * 
		 */
		public function get sortValue():Number{
			throw new Error("please override");
		}
		
		public function sortOne(child:SwapTree):void{
			var idx:int=childList.indexOf(child);
			if(idx==-1)
				throw new Error();
			if(!checkPre(idx,child)){
				checkPost(idx,child);
			}
		}
		
		private function checkPre(idx:int,target:SwapTree):Boolean{
			if(idx<=0)
				return false;
			
			var pre:SwapTree=childList[idx-1];
			if(pre.sortValue>target.sortValue){
				swapChildren(idx-1,idx);
				checkPre(idx-1,target);
				return true;
			}
			return false;
		}
		
		private function checkPost(idx:int,target:SwapTree):Boolean{
			if(idx>=childList.length-1)
				return false;
			
			var post:SwapTree=childList[idx+1];
			if(post.sortValue<target.sortValue){
				swapChildren(idx,idx+1);
				checkPost(idx+1,target);
				return true;
			}
			return false;
		}
		
		protected function swapChildren(one:int,two:int):void{
//			trace("swap",one,two,this);
			var temp:SwapTree=childList[one];
			childList[one]=childList[two];
			childList[two]=temp;
		}
		
		//====================== tree ======================
		protected function addChild_(child:SwapTree):void{
			if(child.parent!=null)
				throw new Error();
			
			if(child.delayedSwapper){
				removeLoadingState();
			}
			
			child.parent=this;
			child.iAmNewbie=true;
			child.superIsNewbie=this.superIsNewbie||this.iAmNewbie;
			this.childList.push(child);
		}
		
		protected function removeChild_(child:SwapTree):void{
			var idx:int=childList.indexOf(child);
			if(idx==-1)
				throw new Error();
			
			childList.splice(idx,1);
			child.parent=null;
		}
		
		public function clear():void{
			while(childList.length>0){
				var child:SwapTree=childList[0] ;
				child.dispose();
			}
		}
		
		public function dispose():void{
			clear();
			parent.removeChild_(this);
		}
		
		//======================= support ================
		public function get isRoot():Boolean{
			return parent==null;
		}
		
		private function removeLoadingState():void{
			for each(var child:SwapTree in childList){
				if(child.delayedSwapper&&!child.isActive){
					child.dispose();
					return;
				}
			}
		}
		
		private function removeActiveState():void{
			for each(var child:SwapTree in childList){
				if(child.delayedSwapper && child.isActive){
					child.dispose();
					return;
				}
			}
		}
		private function checkBelowLoading():Boolean{
			if(idle_loading_loaded==1)
				return true;
			var loading:Boolean=false;
			for each(var child:SwapTree in childList){
				if(child.meOrChildrenLoading){
					loading=true;
					break;
				}
			}
			return loading;
		}
		
		//================= abstract ===============
		protected function swapOn():void{
			throw new Error();
		}
	}
}