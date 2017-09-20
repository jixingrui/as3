package azura.avalon.mouse
{
	import flash.geom.Rectangle;

	public interface MouseDragReceiverI extends MouseTargetI
	{
		function get boundingBox():Rectangle;
		function dragIn(x:int,y:int,target:MouseDragTargetI):void;
		function dragOut(x:int,y:int,target:MouseDragTargetI):void;
		function dragDrop(x:int,y:int,target:MouseDragTargetI):void;
	}
}