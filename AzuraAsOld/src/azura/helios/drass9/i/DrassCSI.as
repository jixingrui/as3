package azura.helios.drass9.i
{
	import azura.common.collections.ZintBuffer;
	import azura.helios.drass9.ui.Drass9;

	public interface DrassCSI
	{
		function receive(msg:ZintBuffer):void;

		function delete_():void;
		function rename(name:String):void;
		function add(name:String):void;
		function save(data:ZintBuffer):void;
		function search(filter:String):void;
		function selectUp(idx:int):void;
		function selectDown(idx:int):void;
		function unselect():void;
		function capture():void;
		function drop():void;
		function pgSize(size:int):void;
		function pgUp():void;
		function pgDown():void;
		function jumpUp():void;
		function jumpDown():void;
	}
}