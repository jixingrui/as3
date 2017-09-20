package azura.banshee.zbox3.container
{
	import azura.banshee.zbox3.Zbox3;

	public interface Zbox3ControllerI
	{
		function get zbox():Zbox3;
		
		function notifyLoadingFinish():void;
		
		function notifyInitialized():void;
		
		function notifyClear():void;
		
		function notifyDispose():void;
		
		function notifyChangeView():void;
		
		function notifyChangeScale():void;
		
		function notifyChangeAngle():void;
	}
}