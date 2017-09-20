package azura.common.algorithm.mover
{
	public interface CycleUserI
	{
		function get frameCount():int;
		function showFrame(frame:int=-1):void;
		function cycleEnd():void;
	}
}