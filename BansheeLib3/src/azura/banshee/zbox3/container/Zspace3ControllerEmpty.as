package azura.banshee.zbox3.container
{
	import azura.banshee.zbox3.Zbox3;
	
	public class Zspace3ControllerEmpty implements Zbox3ControllerI
	{
		public function Zspace3ControllerEmpty()
		{
		}
		
		public function get zbox():Zbox3
		{
			return null;
		}
		
		public function get sortValue():Number{
			return 0;
		}
		
		public function feed(data:Object):void
		{
		}
		
		public function clear():void
		{
		}
		
		public function notifyLoadingFinish():void
		{
		}
		public function notifyReplace():void{
			
		}
		public function notifyClear():void{
			
		}
		
		public function notifyDispose():void
		{
		}
		public function notifyInitialized():void{
			
		}
		public function notifyChangeView():void
		{
		}
		
		public function notifyChangeScale():void
		{
		}
		
		public function notifyChangeAngle():void
		{
		}
	}
}