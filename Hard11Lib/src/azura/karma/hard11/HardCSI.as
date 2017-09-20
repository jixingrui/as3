package azura.karma.hard11
{
	import azura.common.collections.ZintBuffer;

	public interface HardCSI
	{
		function add():void;
		function select(up_down:Boolean,idx:int):void;
		function unselect():void;
		function rename(name:String):void;
		function save(data:ZintBuffer):void;
		function delete_():void;
		function hold():void;
		function drop():void;
		function jump():void;
		function askMore(pageSize:int):void;
	}
}