package old.azura.banshee.naga
{

	public interface AvatarI 
	{
		function set name(value:String):void;
		function turnTo(angle:int):int;
		function set source(value:Naga):void;
		function set scale(value:Number):void;
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set health(value:Number):void;
		function sayText(value:String):void;
		function set onTurn(value:Function):void;
		function set onSelect(value:Function):void;
		function get player():NagaPlayer;
		function clear():void;
	}
}