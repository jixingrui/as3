package azura.common.async2
{
	
	
	public class AsyncLoader2 implements AsyncLoader2I
	{
		internal var config:LoaderConfig;
		private var ret:Function;
		
		internal var kv:KV;
		
		function AsyncLoader2(key:Object)
		{
			if(key==null)
				throw new Error("AsyncLoader2: null key is not allowed");
			
			Async2.enque(this,key);
		}
		
		public function load(ret_This:Function):void{
			if(ret_This==null)
				throw new Error();
			
			this.ret=ret_This;
			kv.load(this);
		}
		
		public function get key():*{
			return kv.key;
		}
		
		public function get value():*{
			return kv.value;
		}
		
		internal function serve():void{
			ret.call(null,this);
		}
		
		/**
		 * 
		 * the loading process cannot be stopped once started. calling release will prevent the result from serving
		 * 
		 */
		public function release(delay:int=0):void{
			kv.release(this,delay);
		}
		
		protected function submit(value:*):void{
			kv.submit(value);
		}
		
		public function process():void
		{
			throw new Error("AsyncLoader2: must override process");
		}
		
		/**
		 * for internal use, don't call 
		 * 
		 */
		public function dispose():void
		{
			throw new Error("AsyncLoader2: must override dispose");
		}
	}
}