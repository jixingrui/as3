package azura.common.async
{
	public interface AsyncLoaderI
	{
		function process():void;
		function dispose():void;
//		function copyFrom(from:AsyncLoaderI):void;
	}
}