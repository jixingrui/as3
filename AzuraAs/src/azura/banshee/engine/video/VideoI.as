package azura.banshee.engine.video
{
	import org.osflash.signals.Signal;

	public interface VideoI
	{
		function cycle(value:Boolean):void;
		function pause():void;
		function resume():void;
		function seek(time:Number):void;
		function get time():Number;
		function get duration():Number;
		function close():void;
		function get onStart():Signal;
		function get onClose():Signal;
	}
}