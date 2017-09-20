package azura.banshee.engine.starling_away
{
	import flash.display.Stage;
	
	public interface Stage3DLayerI2
	{
		function resize(w:int,h:int):void;
		function enterFrame():void;
		function clear():void;
		function dispose():void;
	}
}