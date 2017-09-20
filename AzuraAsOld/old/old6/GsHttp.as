package azura.gallerid3.source
{
	import azura.common.algorithm.crypto.MC5;
	import azura.gallerid3.GalItem;
	
	public class GsHttp
	{
		private var root:String;
		
		public function GsHttp(root:String)
		{
			this.root=root;
		}
		
		public function getAsync(item:GalItem, ret_GalItem:Function):void
		{
			var task:GsHttpTask=new GsHttpTask(item,ret_GalItem);
			task.load(getUrl(item.mc5));
		}
		
		private function getUrl(mc5:String):String{
			return "http://mc5"+MC5.getSize(mc5)+"."+root+"/"+mc5;
		}
	}
}