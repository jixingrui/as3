package azura.gallerid4
{
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;

	public interface Gal4StorageI
	{
		function write(me5:String, cypher:ByteArray):void;
		function readSync(me5:String):ByteArray;
		function readAsync(ret:Gal4):void;
		function deleteFile(me5:String):void;
		function clear():void;
	}
}