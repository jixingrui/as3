package aaa.videoImp
{
	import azura.banshee.zbox3.collection.ZboxVideo3;
	import azura.common.algorithm.mover.TimerI;
	import azura.common.algorithm.mover.TimerRoot;
	
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	public class VideoModel2 implements TimerI
	{
		public var video:ZboxVideo3;
		public var bar:DragBar2;
		
		public var barPercent:Number=0;
		
		private var _mute:Boolean;
		
		public function VideoModel2(){
			TimerRoot.register(1,this);
		}
		
		public function tick():void
		{
			if(video==null || bar==null)
				return;
			
			barPercent=video.video.time/video.video.duration;
//			trace("barpercent",barPercent,this);
			bar.moveBar();
		}
		
		public function get mute():Boolean
		{
			return _mute;
		}
		
		public function set mute(value:Boolean):void
		{
			_mute = value;
			if(value)
				SoundMixer.soundTransform=new SoundTransform(0);
			else
				SoundMixer.soundTransform=new SoundTransform(1);
		}
	}
}