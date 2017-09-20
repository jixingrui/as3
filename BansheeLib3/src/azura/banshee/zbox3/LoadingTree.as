package azura.banshee.zbox3
{
	public class LoadingTree extends SortingTree implements LoadingTreeLoaderListenerI
	{
		//loading
		protected var loader:LoadingTreeLoaderI;
		
		public var iAmLoading:Boolean=false;
		protected var iAmInitialized:Boolean=false;
		public var allChildrenInitialized_:Boolean=false;
		
		public function LoadingTree(){
			super();
		}
		
		//=================== loading ================
		private static var loading:int;
		public function load(loader:LoadingTreeLoaderI):void{
			
//			loading++;
//			trace("loading",loading,this);
			
			if(this.loader!=null){
				this.loader.loadingTreeUnload();
			}
			
			this.loader=loader;
			iAmLoading=true;
			this.loader.loadingTreeLoad(this);
		}
		
		public function notifyLoadingTreeLoaded():void{
			
//			loading--;
//			trace("loading",loading,this);
			
			iAmLoading=false;
			notifyLoadingFinish();
			if(allChildrenInitialized){
				initialize();
			}
		}
		//===================== state =================
		private function get allChildrenInitialized():Boolean{
			if(allChildrenInitialized_)				
				return true;
			
			var allInitialized:Boolean=true;
			if(childList!=null)
				for each(var c:LoadingTree in childList){
				if(c.iAmInitialized==false){
					allInitialized=false;
					break;
				}
			}
			if(allInitialized){
				allChildrenInitialized_=true;
				return true;
			}
			return false;
		}
		
		//=================== ready ===================
		public function initialize():void{
			if(iAmInitialized)
				return;
			
			iAmInitialized=true;
			notifyInitialized();
			if(parent_!=null){
				LoadingTree(parent_).childInitialized(this);
			}
		}
		
		public function childInitialized(child:LoadingTree):void{
			if(iAmInitialized)
				return;
			
			if(!iAmLoading && allChildrenInitialized){
				initialize();
			}
		}
		
		//==================== override =================
		override public function dispose():void{
			if(loader!=null)
				loader.loadingTreeUnload();
			loader=null;
			super.dispose();
		}
		
		//=================== notify ==================
		public function notifyLoadingFinish():void{
			throw new Error("please override");
		}
		
		public function notifyInitialized():void{
			throw new Error("please override");
		}
		
	}
}