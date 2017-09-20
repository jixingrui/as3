package azura.common.async
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.setTimeout;
	
	public class AsyncLoader implements AsyncLoaderI
	{
		private var key_:*;
		internal var value_:*;
		internal var callBack_:Function;
		internal var task:AsyncWorker;
		public var loadNow:Boolean;
		private var syncReturn:Boolean;
		
		internal var isCanceled_:Boolean;
		internal var hasServed_:Boolean;
		
		public function AsyncLoader(key:*,callBack:Function,loadNow:Boolean=false,syncReturn:Boolean=false)
		{
			this.key_=key;
			this.callBack_=callBack;
			this.loadNow=loadNow;
			this.syncReturn=syncReturn;
			if(key==null)
				throw new Error("AsyncUserA: key is null");
		}
		
		public function get key():*
		{
			return key_;
		}
		
		public function get value():*
		{
			return value_;
		}
		
		public function get hasServed():Boolean{
			return hasServed_;
		}
		
		public function serve():void{
			if(syncReturn)
				doServe();
			else
				setTimeout(doServe,0);
		}
		
		private function doServe():void{
			if(isCanceled_||hasServed_)
				return;
			
			hasServed_=true;
			callBack_.call(null,this);
		}
		
		public function submit(value:*):void{
			value_=value;
			task.submit();
		}
		
		public function cancel():void{
			if(!isCanceled_){
				isCanceled_=true;
				task.cancel(this);
			}else{
				trace(getQualifiedClassName(this)+": canceled already!");
			}
		}
		
		public function process():void
		{
			throw new Error("AsyncLoaderI: must override this");
		}
		
		public function dispose():void
		{
			throw new Error("AsyncLoaderI: must override this");
		}
		
		public function copy(from:AsyncLoaderI, to:AsyncLoaderI):void
		{
			throw new Error("AsyncLoaderI: must override this");
		}
	}
}