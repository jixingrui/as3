package azura.gallerid3
{
	import azura.common.collections.ZintBuffer;
	import azura.common.loaders.HttpLoader;
	
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	public class GalMail
	{
		public var mc5:String;
		internal var _data:ZintBuffer;
		public var userData:*;
		private var strongRef:GalMail;

		/**
		 * returns GalMail
		 */
		public var onReady:Signal=new Signal(GalMail);
		
		public function GalMail(mc5:String){
			this.mc5=mc5;
			strongRef=this;
		}
		
		public function dataClone():ZintBuffer
		{
			if(_data==null)
				return null;
			else
				return _data.clone();
		}
		
		internal function set data(value:ZintBuffer):void
		{
			_data = value;
		}
		
		public function dispatchLater():void{
			setTimeout(notify,0);
		}
		
		internal function loadHttp(url:String):void{
			HttpLoader.load(url,onHttpComplete);
		}
		
		public function onHttpComplete(cypher:ByteArray):void{
			this.data=Gallerid.singleton().cache(mc5,cypher,true);
			notify();
		}
		
		private function notify():void{
			onReady.dispatch(this);
			onReady.removeAll();
			strongRef=null;
		}
	}
}