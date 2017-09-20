package azura.avalon.mouse
{
	public interface MouseClickTargetI extends MouseTargetI
	{
		function holdOn(x:int,y:int):void;
		function holdOff():void;
		function click(x:int,y:int):void;
	}
}