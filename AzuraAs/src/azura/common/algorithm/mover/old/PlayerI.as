package azura.common.algorithm.mover.old
{
	public interface PlayerI
	{
		function playOnce(onDone:Function):void;
		function playCycle():void;
		function pause():void;
		function resume():void;
	}
}