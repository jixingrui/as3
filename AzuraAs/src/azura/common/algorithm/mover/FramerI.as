package azura.common.algorithm.mover
{
	public interface FramerI
	{
		function get frameCount():int;
		function showFrame(frame:int=-1):void;
		/**
		 * 
		 * @return the recorded current frame for target change and resume
		 * 
		 */
		function get nextFrameIdx():int;
	}
}