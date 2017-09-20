package azura.banshee.mass.syncher
{
	import azura.banshee.mass.sdk.MassCoder;
	import azura.banshee.mass.sdk.MassCoderA4;
	
	import flash.desktop.NativeApplication;
	import flash.utils.setTimeout;
	
	public class SyncherSDK extends MassCoderA4
	{
		public function SyncherSDK()
		{
			super(".");
		}
		
		override public function act(token:String,mc:MassCoder):Boolean{
//			var tree:MassTree3=action.host.tree;
			function shutLight():void{
//				tree.syncIn(action.targetPath);
//				trace("slap",action.targetPath,"SyncherSDK");
				tree.slap(mc.target);
			}
			if(token=="c关灯.#开边关.#人在外的门.双门.卫生间.09.#母框.总.."){
				setTimeout(shutLight,2000);
				return true;
			}else if(token=="叉.13.#母框.总.."){
				NativeApplication.nativeApplication.exit();
				return true;
			}else if(token=="c关.01.#母框.总.."){
				NativeApplication.nativeApplication.exit();
				return true;
			}
			return false;
		}
	}
}