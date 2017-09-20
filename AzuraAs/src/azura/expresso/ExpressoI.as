package azura.expresso
{
	import azura.common.collections.ZintBuffer;

	public interface ExpressoI
	{
		function decode(zb:ZintBuffer):void;
		function encode():ZintBuffer;
	}
}