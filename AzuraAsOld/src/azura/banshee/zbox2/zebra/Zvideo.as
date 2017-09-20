package azura.banshee.zbox2.zebra
{
	import azura.banshee.engine.video.VideoI;
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	
	public class Zvideo extends Zbox2Container implements Zbox2ControllerI
	{
		public var handle:VideoI;
		
		public function Zvideo(parent:Zbox2)
		{
			super(parent);
		}
		
		public function play(url:String):void{
//			handle=zbox.replica.loadFromVideoUrlOld(url);
//			handle.cycle(false);
//			zbox.replica.te
		}
		
	}
}