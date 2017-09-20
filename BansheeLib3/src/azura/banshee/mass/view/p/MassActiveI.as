package azura.banshee.mass.view.p
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;

	public interface MassActiveI
	{
		function act(action:MassAction):void;
//		function get model():MassTreeN;
	}
}