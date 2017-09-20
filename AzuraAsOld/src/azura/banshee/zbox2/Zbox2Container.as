package azura.banshee.zbox2
{

	public class Zbox2Container implements Zbox2ControllerI
	{
		public function Zbox2Container(parent:Zbox2,isState:Boolean=false)
		{
			_zbox=parent.newChild(isState);
			_zbox.controller=this;
		}
		
		protected var _zbox:Zbox2;

		public function get zbox():Zbox2
		{
			return _zbox;
		}
		
		private var sortValue_:Number;
		public function set sortValue(value:Number):void{
			sortValue_=value;
		}
		/**
		 * larger covers smaller
		 * 
		 */
		public function get sortValue():Number
		{
			return sortValue_;
		}
		
		public function notifyLoadingFinish():void
		{

		}
		
		public function notifyNewBieLoaded():void{
			
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