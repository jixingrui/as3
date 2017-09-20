package azura.common.collections
{
	public interface ZintCodecI
	{
		function readFrom(reader:ZintBuffer):void;
		function writeTo(writer:ZintBuffer):void;
	}
}