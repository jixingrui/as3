package azura.banshee.naga
{

	public interface NagaI
	{
		function get rowCount():int;
		function get frameCount():int;
		function getFrame(row:int,frame:int):Frame;
	}
}