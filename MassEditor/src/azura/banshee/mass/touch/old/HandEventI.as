package azura.banshee.mass.touch.old
{
	public interface HandEventI
	{
		/*
		*no down. replaced by slide. double tap is double up
		*/
		function slide(id:int,x:int,y:int):void;
		function up(id:int,x:int,y:int):void;
		function out(id:int,x:int,y:int):void;
	}
}