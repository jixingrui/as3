package azura.banshee.mass.model.v3
{
	import azura.banshee.mass.model.MassAction;

	public interface ActorI
	{
		function act(action:MassAction,logic_visual:Boolean):void;
	}
}