package azura.common.ui.list.motor
{
	public interface ListMotorItemI
	{
		function get listItemLength():Number;
		function notifyMove(pos:Number):void;
		function set listItemShow(value:Boolean):void;
	}
}