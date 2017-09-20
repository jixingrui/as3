package azura.common.old
{
	import flash.display.Stage;
	import flash.display.Stage3D;

	public interface Stage3DI
	{
		function get active():Boolean;
		function set active(value:Boolean):void;
		function boot(stage:Stage,stage3D:Stage3D):void;
		function update():void;
	}
}