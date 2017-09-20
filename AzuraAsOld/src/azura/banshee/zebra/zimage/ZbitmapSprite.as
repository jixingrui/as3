package azura.banshee.zebra.zimage
{
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.i.ZebraBranchNodeI;
	import azura.banshee.zebra.i.ZebraI;
	import azura.banshee.zebra.zode.ZframeOp;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.banshee.zebra.zode.Zshard;
	import azura.common.algorithm.crypto.MC5Old;
	import azura.common.util.ByteUtil;
	import azura.expresso.PrimitiveE;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;
	import mx.utils.UIDUtil;
	
	public class ZbitmapSprite extends Zshard implements ZebraBranchNodeI
	{
		private var texInUse:ZsheetOp;
		private var texToUse:ZsheetOp;
		
		public function ZbitmapSprite(parent:ZboxOld)
		{
			super(parent);
		}
		
		public function load(value:Zebra,ret:Function):void{
			if(value==null)
				return;
			
			loadBitmapData(Zbitmap(value.branch).bitmapData);
		}
		public function show():void{
			
		}
		
		public function get boundingBox():Rectangle{
			return null;
		}
		
		public function loadBitmapData(bd:BitmapData):void{
			if(texToUse!=null)
				texToUse.loader.release(3000);
			
			texToUse=new ZsheetOp();
			texToUse.onLoaded.add(onLoaded);
			texToUse.textureType=ZsheetOp.BitmapData_;
			texToUse.bitmapData=bd;
			texToUse.me5=UIDUtil.createUID();
			host.loadTexture(texToUse);
		}
		
		private function onLoaded():void{
			if(texInUse!=null)
				texInUse.loader.release(3000);
			
			texInUse=texToUse;
			texToUse=null;
			
			var zs:ZframeOp=new ZframeOp();
			zs.sheet=texInUse;
			display(zs);
		}
		
		public function look(viewLocal:Rectangle):void{
		}
		
		public function set angle(value:Number):void
		{
			host.renderer.rotation=value;
		}
		private var angle_:Number;
		public function get angle():Number
		{
			return angle_;
		}
		
		override public function dispose():void
		{
			if(texInUse!=null)
				texInUse.loader.release(3000);
			if(texToUse!=null)
				texToUse.loader.release(3000);
			texInUse=null;
			texToUse=null;
			super.dispose();
		}
		
	}
}