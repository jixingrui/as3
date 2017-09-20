package azura.banshee.zebra.data.wrap
{
	public interface Zframe2I
	{
		function startUse(user:Zframe2ListenerI):void;
		function endUse(user:Zframe2ListenerI):void;
		function get nativeTexture():Object;
		function get dx():Number;
		function get dy():Number;
		function get width():Number;
		function get height():Number;
//		function get smoothing():Boolean;
	}
}