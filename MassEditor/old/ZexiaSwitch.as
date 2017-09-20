package aaa.zexiaImp
{
	import azura.banshee.mass.sdk.MassSwitch2;
	import azura.banshee.zbox3.Zspace3;
	
	public class ZexiaSwitch extends MassSwitch2
	{
		public var model:ZexiaModel;
		public function ZexiaSwitch(space:Zspace3)
		{
			super(".");
			model=new ZexiaModel(space);
			register(new SwitchPrime(model));
		}
	}
}