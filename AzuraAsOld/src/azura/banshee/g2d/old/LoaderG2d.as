package azura.banshee.g2d.old
{
	import azura.common.async2.Async2;
	import azura.common.async2.AsyncLoader2;
	
	public class LoaderG2d extends AsyncLoader2
	{
		
		public var pack:LoaderPackG2d;
		
		public function LoaderG2d(pack:LoaderPackG2d)
		{
			super(getKey(pack));
			this.pack=pack;
		}
		
		protected function getKey(pack:LoaderPackG2d):String{
			throw new Error("must override this");
		}
	}
}