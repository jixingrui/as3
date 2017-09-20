package azura.banshee.zbox3.container
{
	import azura.banshee.zbox3.Zbox3;

	public class Zbox3Container implements Zbox3ControllerI
	{
		protected var _zbox:Zbox3;
		
		public function Zbox3Container(parent:Zbox3)
		{
			_zbox=parent.newChild();
			_zbox.controller=this;
		}

		public function get zbox():Zbox3
		{
			return _zbox;
		}
		
		public function notifyLoadingFinish():void
		{

		}
		
		
		public function notifyInitialized():void{
			
		}
		
		public function notifyClear():void{
			
		}
		
		public function notifyDispose():void{
			
		}
		
		public function notifyChangeScale():void
		{
		}
		
		public function notifyChangeAngle():void
		{
		}
		
		public function notifyChangeView():void
		{
		}
	}
}