package azura.touch.watcherOld
{
	public interface WatcherDragI
	{
		function onDragStart(we:WatcherEvent):void;
		
		function onDragMove(we:WatcherEvent):void;
		
		function onDragEnd(we:WatcherEvent):void;
	}
}