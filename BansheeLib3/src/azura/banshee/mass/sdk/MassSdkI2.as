package azura.banshee.mass.sdk
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.model.MassTreeN;

	public interface MassSdkI2
	{
		function chainAction(action:MassAction):Boolean;
	}
}