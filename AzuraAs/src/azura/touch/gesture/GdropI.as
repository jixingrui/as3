package azura.touch.gesture
{
	import azura.touch.TouchBox;

	public interface GdropI extends GestureI
	{
		function drop(target:TouchBox):Boolean;	
	}
}