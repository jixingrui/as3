package aaa.videoImp
{
	import azura.banshee.mass.model.MassAction;
	import azura.banshee.mass.sdk.MassSwitch2;
	import azura.banshee.mass.view.MassTreeNV2;
	
	public class Switch_smallPlayer2 extends MassSwitch2
	{
		private var model:VideoModel2;
		public function Switch_smallPlayer2(model:VideoModel2)
		{
			super("#小播放器.#播放模式..");
			this.model=model;
		}
		
		override public function act(from:MassTreeNV2, action:MassAction):Boolean{
			var to:MassTreeNV2=from.tree.getBox(action.targetPath);
			if(from.model.path=="c暂停视频.#暂停钮.暂停播放钮.小播放器位置.#小播放器.#播放模式.."){
				model.video.video.pause();
				return true;
			}
			if(from.model.path=="c播放视频.#播放钮.暂停播放钮.小播放器位置.#小播放器.#播放模式.."){
				model.video.video.resume();
				return true;
			}
			if(from.model.path=="c关闭视频.叉.三个钮.小播放器位置.#小播放器.#播放模式.."){
				model.barPercent=0;
				model.video.video.close();
				model.video=null;
				model.bar=null;
				return true;
			}			
			if(from.model.path=="c换播放范围.全屏.三个钮.小播放器位置.#小播放器.#播放模式.."){
				from.tree.activate(action.targetPath);
				to=from.tree.getBox(action.targetPath);
				model.video.zbox.replica.width=to.zbox.width;
				model.video.zbox.replica.height=to.zbox.height;
				model.video.zbox.move(to.zbox.x,to.zbox.y);
				return true;
			}						
			if(from.model.path=="c关掉声音.#点了就没声.静音.三个钮.小播放器位置.#小播放器.#播放模式.."){
				model.mute=true;
				return true;
			}		
			if(from.model.path=="c打开声音.#点了就有声.静音.三个钮.小播放器位置.#小播放器.#播放模式.."){
				model.mute=false;
				return true;
			}					
			if(from.model.path=="c如果是静音.#小播放器.#播放模式.."){
				if(model.mute){
					from.tree.activate(action.targetPath);
				}
				return true;
			}		
			if(from.model.path=="钮.进度条.小播放器位置.#小播放器.#播放模式.."){
				model.bar=new DragBar2();
				model.bar.model=model;
				model.bar.dot=from.zbox;
				model.bar.line=to.zbox;
				model.bar.init();
				
				to.zbox.removeGestureAll();
				to.zbox.addGesture(model.bar);
				return true;
			}
			if(from.model.path=="c启动钮.#小播放器.#播放模式.."){
				return true;
			}		
			trace(" <msg> ",action.stringMsg, "<from>",from.model.path," <to> ",action.targetPath," <at> ",path,this);
			return false;
		}
	}
}