package azura.banshee.engine
{
	import flash.display.Stage;
	
	public interface Stage3DLayerI
	{
		function init(stage:Stage):void;
		function clear():void;
		function dispose():void;
		function enterFrame():void;
	}
}