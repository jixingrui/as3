package azura.banshee.zbox2
{
	
	public class Zspace2ControllerEmpty implements Zbox2ControllerI
	{
		public function Zspace2ControllerEmpty()
		{
		}
		
		public function get zbox():Zbox2
		{
			return null;
		}
		
		public function get sortValue():Number
		{
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
		
		public function notifyClear():void{
			
		}
		
		public function notifyDispose():void
		{
		}
		public function notifyNewBieLoaded():void{
			
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