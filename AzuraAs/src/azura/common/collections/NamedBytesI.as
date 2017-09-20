package azura.common.collections
{
	
	public interface NamedBytesI extends BytesI
	{
		function get name():String;
		function set name(value:String):void;
		function clone():NamedBytesI;
	}
}