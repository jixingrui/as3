package azura.common.collections
{
	public interface BytesI
	{
		function toBytes():ZintBuffer;
		function fromBytes(zb:ZintBuffer):void;
	}
}