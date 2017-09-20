package azura.helios.hard10.ie
{
	import azura.common.collections.ZintBuffer;

	public interface HardCsI
	{
		function hold():void;
		function add(data:ZintBuffer):void;
		function rename(name:String):void;
		function delete_():void;
		function drop():void;
		function select(up_down:Boolean,idx:int):void;
		function unselect():void;
		function save(data:ZintBuffer):void;
		function jump():void;
		function askMore(up_down:Boolean,pageSize:int):void;
	}
}