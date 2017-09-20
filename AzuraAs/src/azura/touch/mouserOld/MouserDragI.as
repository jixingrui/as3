package azura.touch.mouserOld
{
	public interface MouserDragI
	{
		function onDragStart(md:MouserDrag):void;
		
		function onDragMove(md:MouserDrag):void;
		
		function onDragEnd(md:MouserDrag):void;
	}
}