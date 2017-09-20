package old.azura.avalon.ice.g2d
{
	import away3d.core.managers.Stage3DProxy;

	public interface Stage3DEngineI
	{
		function boot(proxy:Stage3DProxy):void;
		function resize(width:int,height:int):void;
	}
}