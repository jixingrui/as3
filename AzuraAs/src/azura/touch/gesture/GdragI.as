package azura.touch.gesture
{
	import azura.touch.TouchBox;

	public interface GdragI extends GestureI
	{
		function dragStart(x:Number,y:Number):Boolean;
		function dragMove(x:Number,y:Number,dx:Number,dy:Number):Boolean;
		function dragEnd():Boolean;
		
		function get touchBox():TouchBox;
		function set touchBox(box:TouchBox):void;
	}
}