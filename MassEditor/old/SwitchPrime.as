package aaa.zexiaImp
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.sdk.MassSwitch2;
	import azura.banshee.mass.view.MassTreeNV2;
	
	public class SwitchPrime extends MassSwitch2
	{
		private var model:ZexiaModel;
		public function SwitchPrime(model:ZexiaModel)
		{
			super("#主要部件及下级界面..");
			this.model=model;
		}
		
		override public function act(action:MassAction):Boolean{
//			var to:MassTreeNV2=from.tree.getBox(action.targetPath);
			if(action.host.path=="识别区1.识别区.左侧图区.#111变频驱动一体机.#主要部件及下级界面.."){
				model.showHD("zzz/p1p1p1HD/1.jpg");
				return true;
			}else if(action.host.path=="识别区2.识别区.左侧图区.#111变频驱动一体机.#主要部件及下级界面.."){
				model.showHD("zzz/p1p1p1HD/2.jpg");
				return true;
			}
			
			return false;
		}
	}
}