package common.async
{
	

	public class AsyncUserA implements AsyncUserI
	{
		private var _key:*;
		internal var discarded:Boolean;
		internal var served:Boolean;
		internal var task:AsyncTask;
		
		public function AsyncUserA(key:*)
		{
			this._key=key;
			if(key==null)
				throw new Error("AsyncUserA: key is null");
		}
		
		public function get key():*
		{
			return _key;
		}
		
		public function process(answer:AsyncTask):void
		{
			throw new Error("AsyncUser: must override this");
		}
		
		public function ready(value:AsyncBoxI):void{
			throw new Error("AsyncUser: must override this");
		}
		
		/**
		 * 
		 * @return interrupted
		 * 
		 */
		public function discard():Boolean{
			if(!discarded){
				discarded=true;
				task.discard(this);
			}else{
				trace("discarded twice!");
			}
			return !served;
		}
		
		public function get isDiscarded():Boolean{
			return discarded;
		}
	}
}