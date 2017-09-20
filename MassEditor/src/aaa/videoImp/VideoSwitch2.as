package aaa.videoImp
{
	import azura.banshee.mass.sdk.MassSwitch;
	import azura.banshee.mass.sdk.MassSwitch2;

	public class VideoSwitch2 extends MassSwitch2
	{
		public var model:VideoModel2;
		
		public function VideoSwitch2()
		{
			super(".");
			model=new VideoModel2();
			register(new Switch_frontpage2(model));
			register(new Switch_smallPlayer2(model));
			register(new Switch_largePlayer2(model));
		}
	}
}