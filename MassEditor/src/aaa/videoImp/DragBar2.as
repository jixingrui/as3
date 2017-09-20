package aaa.videoImp
{
	import azura.banshee.zebra.Zebra2Old;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zbox3.collection.ZboxBitmap3;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GdragI;
	
	import flash.display.BitmapData;
	
	public class DragBar2 implements GdragI
	{
		public var dot:Zbox3;
		public var line:Zbox3;
		public var model:VideoModel2;
		
		public function init():void{			
			model.bar.dot.move(-line.width/2+dot.width/2,0);
			var bd:BitmapData=new BitmapData(line.width,10,true,0x44aaaaaa);
//			var bg:ZebraC3=new ZebraC3(line);
//			bg.feedzebr(new Zebra2().fromBitmapData(bd));
//			bg.zbox.sortValue=-1;
			var bg:ZboxBitmap3=new ZboxBitmap3(line);
			bg.fromBitmapData(bd);
			bg.zbox.sortValue=-1;
			line.sortOne(bg.zbox);
			
			moveBar();
		}
		
		public function moveBar():void{
			dot.move((model.barPercent-0.5)*line.width,0);
		}
		
		public function dragStart():Boolean
		{
			return false;
		}
		
		public function dragMove(x:Number, y:Number, dx:Number, dy:Number):Boolean
		{
			x-=line.xGlobal;
			y-=line.yGlobal;
			x=Math.max(-line.width/2+dot.width/2,x);
			x=Math.min(line.width/2-dot.width/2,x);
//			dot.move(x,0);
			
			model.barPercent=(x+line.width/2)/line.width;
			var time:Number=model.video.video.duration*model.barPercent;
			model.video.video.seek(time);
			
			moveBar();
//			trace("seek percent=",percent,"time=",time,this);
			return false;
		}
		
		public function dragEnd():Boolean
		{
			return false;
		}
		
		public function get touchBox():TouchBox
		{
			return null;
		}
		
		public function set touchBox(box:TouchBox):void
		{
		}
	}
}