package azura.banshee.mass.layer
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.sdk.MassSdkI2;
	import azura.banshee.mass.view.MassTreeNV2;
	import azura.common.ui.alert.Toast;
	
	public class DisplayerSdk2 implements MassSdkI2
	{
		public function chainAction(action:MassAction):Boolean
		{
			trace("coder:",action.stringMsg,"to",action.targetPath,this);
			Toast.show(action.stringMsg);
			return true;
		}
	}
}