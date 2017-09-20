package azura.banshee.zebra.node
{
	import azura.banshee.zebra.zimage.ZbitmapSprite;
	import azura.banshee.zebra.zode.ZboxOld;
	
	import flash.display.BitmapData;
	
	public class ZbitmapNode extends ZboxOld
	{
		private var sprite:ZbitmapSprite;
		
		public function ZbitmapNode(parent:ZboxOld)
		{
			super(parent);
			sprite=new ZbitmapSprite(this);
		}
		
		public function draw(source:BitmapData):void{
			sprite.loadBitmapData(source);
			
//			super.box.lbb.x=-source.width/2;
//			super.box.lbb.y=-source.height/2;
			super.box.bb.width=source.width;
			super.box.bb.height=source.height;
			super.updateTouch();
//			super.re
		}
	}
}