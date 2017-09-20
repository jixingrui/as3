package azura.banshee.zbox2
{

	public interface Zbox2ControllerI
	{
		function get zbox():Zbox2;
		
		function get sortValue():Number;
		
		/**
		 * Dispatched when me and all children finish loading
		 * @return keep bubbling
		 * 
		 */
		function notifyLoadingFinish():void;
		
		function notifyNewBieLoaded():void;
		
		function notifyClear():void;
		
		function notifyDispose():void;
		
		function notifyChangeView():void;
		
		function notifyChangeScale():void;
		
		function notifyChangeAngle():void;
	}
}