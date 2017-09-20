package azura.common.ui.list.motor
{
	public interface ListMotorMotherI
	{
		function get shellLength():Number;
		function set hitHead(value:Boolean):void;
		function set hitTail(value:Boolean):void;
		function changeBoss(idx:int):void;
	}
}