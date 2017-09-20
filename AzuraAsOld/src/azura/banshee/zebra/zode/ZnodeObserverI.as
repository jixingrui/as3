package azura.banshee.zebra.zode
{
	public interface ZnodeObserverI
	{
		function znodeChanged():void;
		function get priority():int;
	}
}