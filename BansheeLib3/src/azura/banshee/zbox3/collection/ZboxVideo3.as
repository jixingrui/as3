package azura.banshee.zbox3.collection
{
	import azura.banshee.engine.TextureResI;
	import azura.banshee.engine.video.VideoStarling;
	import azura.banshee.zbox3.LoadingTreeLoaderI;
	import azura.banshee.zbox3.LoadingTreeLoaderListenerI;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	
	public class ZboxVideo3 extends Zbox3Container implements LoadingTreeLoaderI
	{
		public var video:VideoStarling;
		private var cycle:Boolean;
		public var no_f1_f2:int=0;
		
		public function ZboxVideo3(parent:Zbox3)
		{
			super(parent);
		}
		
		public function play(url:String,cycle:Boolean):void{
			this.cycle=cycle;
			zbox.replica.smoothing=true;
			
			video=new VideoStarling(url);
			zbox.load(this);
		}
		
		override public function notifyDispose():void{
			if(video!=null)
				video.close();
		}
		
		//========= loader ============
		public function loadingTreeLoad(listener:LoadingTreeLoaderListenerI):void
		{
			video.load(onLoaded);
			function onLoaded(vs:VideoStarling):void{
				zbox.width=vs.width;
				zbox.height=vs.height;
				zbox.notifyLoadingTreeLoaded();
				if(video.value!=null)
					video.cycle(this.cycle);
				
				checkF();
			}
		}
		
		private function checkF():void{
			if(no_f1_f2==1){
				zbox.stretchTo1(Zbox3(zbox.parent).width,Zbox3(zbox.parent).height);
			}else if(no_f1_f2==2){
				zbox.stretchTo2(Zbox3(zbox.parent).width,Zbox3(zbox.parent).height);
			}
		}
		
		public function get resource():TextureResI
		{
			return video;
		}
		
		public function loadingTreeUnload():void
		{
		}
		
	}
}