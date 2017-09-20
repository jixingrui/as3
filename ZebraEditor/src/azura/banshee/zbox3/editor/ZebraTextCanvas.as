package azura.banshee.zbox3.editor
{
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.banshee.zbox3.collection.ZboxText;
	import azura.banshee.zebra.Zfont;
	import azura.common.graphics.Draw;
	
	import flash.display.BitmapData;
	
	public class ZebraTextCanvas
	{
		public var ec:EditorCanvas3;
		public var actor:ZboxText;
		
		public function activate(ec:EditorCanvas3):void
		{
			this.ec=ec;
			
			actor=new ZboxText(ec.space);
		}
		
		public function showText(zfont:Zfont):void{
			actor.fromFont(zfont);
//			var zebra:Zebra3=new Zebra3();
//			var bd:BitmapData=Draw.font(zfont);
//			actor.fromBitmapData(bd);
		}
		
		public function deactivate():void{
			actor.zbox.dispose();
		}
		
	}
}