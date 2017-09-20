package azura.banshee.zbox2.zebra
{
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zbox2.zebra.zimage.ZimageBitmapC2;
	import azura.banshee.zbox2.zebra.zimage.ZimageLargeC2;
	import azura.banshee.zbox2.zebra.zimage.ZimageSmallC2;
	import azura.banshee.zbox2.zebra.zmatrix.ZhlineC2;
	import azura.banshee.zbox2.zebra.zmatrix.ZmatrixC2;
	import azura.banshee.zbox2.zebra.zmatrix.ZvlineC2;
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zebra.branch.ZHline2;
	import azura.banshee.zebra.branch.ZVline2;
	import azura.banshee.zebra.branch.Zbitmap2;
	import azura.banshee.zebra.branch.Zblank2;
	import azura.banshee.zebra.branch.ZimageLarge2;
	import azura.banshee.zebra.branch.ZimageSmall2;
	import azura.banshee.zebra.branch.Zmatrix2;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4;
	
	public class ZebraC2 extends Zbox2Container implements Zbox2ControllerI
	{
		public var opDisplaying:Zbox2Container;
		
		public function ZebraC2(parent:Zbox2)
		{
			super(parent);
		}
		
		public function load(me5:String):void{
			var data:ZintBuffer=Gal4.readSync(me5);
			data.uncompress();
			var zebra:Zebra2Old=new Zebra2Old();
			zebra.fromBytes(data);
			this.feed(zebra);
		}
		
		public function stretchTo(width:int,height:int):void{
			var scaleX:Number=width/zbox.width;
			var scaleY:Number=height/zbox.height;
			zbox.replica.scaleX=scaleX;
			zbox.replica.scaleY=scaleY;
		}
		
		public function noStretch():void{
			zbox.replica.scaleX=1;
			zbox.replica.scaleY=1;
		}
		
		public function feed(zebra:Zebra2Old):void{
			//			trace("feed",zebra.branch,this);
			//			zbox.move(0,0);
			
			//			zbox.boxC.bb=zebra.boundingBox;
			zbox.width=zebra.boundingBox.width;
			zbox.height=zebra.boundingBox.height;
			zbox.pivotX=-zebra.boundingBox.xc;
			zbox.pivotY=-zebra.boundingBox.yc;
			zbox.updateTouch();
			
			if(zebra.branch is Zblank2){
				zbox.clear();
				if(!(opDisplaying is ZblankC2))
					opDisplaying=new ZblankC2(this.zbox);
				//				ZblankC2(opDisplaying).clear();
			}else if(zebra.branch is Zbitmap2){
				if(!(opDisplaying is ZimageBitmapC2))
					opDisplaying=new ZimageBitmapC2(this.zbox);
				ZimageBitmapC2(opDisplaying).feed(zebra.branch as Zbitmap2);
			}else if(zebra.branch is ZimageSmall2){
				if(!(opDisplaying is ZimageSmallC2))
					opDisplaying=new ZimageSmallC2(this.zbox);
				ZimageSmallC2(opDisplaying).feed(zebra.branch as ZimageSmall2);
			}else if(zebra.branch is ZimageLarge2){
				if(!(opDisplaying is ZimageLargeC2))
					opDisplaying=new ZimageLargeC2(this.zbox);
				ZimageLargeC2(opDisplaying).feed(zebra.branch as ZimageLarge2);
			}else if(zebra.branch is ZHline2){
				if(!(opDisplaying is ZhlineC2))
					opDisplaying=new ZhlineC2(this.zbox);
				var h:ZHline2=zebra.branch as ZHline2;
				ZhlineC2(opDisplaying).feed(h.line,h.fps);
			}else if(zebra.branch is ZVline2){
				if(!(opDisplaying is ZvlineC2))
					opDisplaying=new ZvlineC2(this.zbox);
				ZvlineC2(opDisplaying).feed(zebra.branch as ZVline2);
			}else if(zebra.branch is Zmatrix2){
				if(!(opDisplaying is ZmatrixC2))
					opDisplaying=new ZmatrixC2(this.zbox);
				ZmatrixC2(opDisplaying).feed(zebra.branch as Zmatrix2);
			}
		}
		
		override public function notifyClear():void{
			opDisplaying=null;
			//			zbox.move(0,0);
		}
		
	}
}
