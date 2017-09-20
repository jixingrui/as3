package azura.hellios.drass6
{
	import common.collections.ZintBuffer;

	public interface DrassEditorI
	{
		function _read(node:Node):void;
		function _clear():void;
		function _save():ZintBuffer;
	}
}