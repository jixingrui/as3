package azura.common.old
{
	import away3d.core.managers.Stage3DProxy;
	
	import flash.display.Stage;

	public interface Stage3DLayerIOld
	{
		function get active():Boolean;
		
		function set active(value:Boolean):void;
		
		function boot(proxy:Stage3DProxy):void;
		
		function reboot():void;
		
		function resize(width:int,height:int):void;
		
		function enterFrame():void;
	}
}