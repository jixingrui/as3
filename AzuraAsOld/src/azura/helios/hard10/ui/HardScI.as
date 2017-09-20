package azura.helios.hard10.ui
{
	import azura.helios.hard10.hub.HardItem;

	public interface HardScI
	{
		function appendDown(more:Vector.<HardItem>):void;
		function downComplete():void;
		function fillUp(up:Vector.<HardItem>):void;
		function clear(up_down:Boolean):void;
	}
}