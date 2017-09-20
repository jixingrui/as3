package azura.banshee.zbox3
{
	import azura.banshee.engine.TextureResI;

	public interface LoadingTreeLoaderI
	{
		function loadingTreeLoad(listener:LoadingTreeLoaderListenerI):void;
		function loadingTreeUnload():void;
		function get resource():TextureResI;
	}
}