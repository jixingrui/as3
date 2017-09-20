package aaa.videoImp
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.sdk.MassSwitch2;
	import azura.banshee.mass.view.MassTreeNV2;
	import azura.banshee.zbox3.collection.ZboxVideo3;
	
	import flash.desktop.NativeApplication;
	
	public class Switch_frontpage2 extends MassSwitch2
	{
		private var model:VideoModel2;
		public function Switch_frontpage2(model:VideoModel2)
		{
			super("#首页模式..");
			this.model=model;
		}
		
		override public function act(from:MassTreeNV2, action:MassAction):Boolean{
			var to:MassTreeNV2=from.tree.getBox(action.targetPath);
			
			if(from.model.path=="关闭.#首页模式.."){
				NativeApplication.nativeApplication.exit();
				return true;
			}
			if(from.model.path=="c放视频.中文状态.长方形定位.#首页模式.."){
				model.video=new ZboxVideo3(to.zbox);
				model.video.play("./assets/cn.flv");
//				model.bar.video=model.video.handle;
				return true;
			}			
			if(from.model.path=="c播放英文视频.英文状态.长方形定位.#首页模式.."){
				model.video=new ZboxVideo3(to.zbox);
				model.video.play("./assets/en.flv");
//				model.bar.video=model.video.handle;
				return true;
			}	
			if(from.model.path=="c播放日文视频.日语状态.长方形定位.#首页模式.."){
				model.video=new ZboxVideo3(to.zbox);
				model.video.play("./assets/jp.flv");
//				model.bar.video=model.video.handle;
				return true;
			}	
			trace(" <msg> ",action.stringMsg, "<from>",from.model.path," <to> ",action.targetPath," <at> ",path,this);
			return false;
		}
	}
}