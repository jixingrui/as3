package azura.common.sound
{
	import azura.common.algorithm.crypto.Rot;
	import azura.common.collections.ZintBuffer;
	import azura.common.loaders.HttpLoader;
	import azura.gallerid4.CancelableI;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class VoiceHttp implements CancelableI
	{
		private static var root:String="http://oss.shoujiguang.com/voice/";
		
		private static var me_me:Dictionary=new Dictionary();
		
		public static function set config(c:VoiceConfigI):void{
			root=c.voice;
		}
		
		public static function download(mc5:String,ret_ZintBuffer:Function):CancelableI{
			var url:String=root+mc5;
			var me:VoiceHttp=new VoiceHttp(ret_ZintBuffer);
			me_me[me]=me;
			me.hl=HttpLoader.load(url,me.loaded);
			
			return me;
		}
		
		public static function cancelAll():void{
			for each(var loader:CancelableI in me_me){
				loader.cancel();
			}
			me_me=new Dictionary();
		}
		
		private var hl:CancelableI;
		private var ret:Function;
		private var strong:VoiceHttp;
		
		public function VoiceHttp(ret:Function){
			this.ret=ret;
			strong=this;
		}
		
		public function loaded(raw:ByteArray):void{
			delete me_me[this];
			strong=null;
			var mp3:ZintBuffer=Rot.decrypt(raw);
			ret.call(null,mp3);
		}
		
		public function cancel():void{
			hl.cancel();
		}
		
	}
}