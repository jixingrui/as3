package azura.gallerid.gal
{
	import azura.gallerid3.i.GsI;
	

	public interface GalleridIOld extends GalObjI
	{
		function getData(mc5:String,ret_ByteArray:Function):void;
		function close():void;
	}
}