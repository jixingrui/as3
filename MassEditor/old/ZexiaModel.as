package aaa.zexiaImp
{
	import azura.banshee.zbox3.Zspace3;
	import azura.common.ui.button.Zoomer;

	public class ZexiaModel
	{
		public var space:Zspace3;
		
		public function ZexiaModel(space:Zspace3)
		{
			this.space=space;
		}
		
		public function showHD(url:String):void{
			space.pauseTouch();
			var z:Zoomer=new Zoomer();
			z.onClose.addOnce(onClose);
			z.urlLarge="assets/zzz/p1p1p1HD/1.jpg";
		}
		
		private function onClose():void{
			space.resumeTouch();
		}
	}
}