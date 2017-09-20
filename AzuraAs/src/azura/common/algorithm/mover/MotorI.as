package azura.common.algorithm.mover
{
	public interface MotorI
	{
		function jumpTo(x:Number,y:Number):void;
		function turnTo(angle:int):int;
		function go():void;
		function stop():void;
	}
}