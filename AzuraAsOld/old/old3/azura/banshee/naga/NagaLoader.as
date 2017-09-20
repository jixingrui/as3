package old.azura.banshee.naga
{
	import azura.common.async2.AsyncLoader2;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid.Gal_Http2Old;
	
	/**
	 * value:Naga
	 * 
	 */
	public class NagaLoader extends AsyncLoader2
	{
//		private var md5:String;
		public function NagaLoader(md5:String)
		{
			super(md5);
//			this.md5=md5;
		}
		
		override public function process():void
		{
			new Gal_Http2Old(key as String).load(ready);
			function ready(gh:Gal_Http2Old):void{
				var zb:ZintBuffer=ZintBuffer(gh.value);
				zb.uncompress();
				var naga:Naga=new Naga(zb);
				submit(naga);
			}
		}
		
		override public function dispose():void
		{
		}
	}
}