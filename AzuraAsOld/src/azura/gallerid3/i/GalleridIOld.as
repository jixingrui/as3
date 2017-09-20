package azura.gallerid3.i
{
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.ByteArray;
	import azura.gallerid3.GalMail;
	
	public interface GalleridIOld
	{
		function touch(mc5:String):void;
		function getData(mc5:String,ret_GalItem:Function=null):GalMail;
		function cache(mc5:String,cypher:ByteArray):ZintBuffer;
	}
}