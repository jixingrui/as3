package azura.karma.hard11.service
{
	import azura.common.collections.ZintBuffer;
	import azura.karma.run.Karma;

	public interface HardTunnelI
	{
		function sendHard(msg:Karma,by:HardC_SC):void;
		function sendCustom(msg:ZintBuffer):void;
	}
}