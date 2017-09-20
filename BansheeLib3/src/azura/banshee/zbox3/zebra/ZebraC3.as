package azura.banshee.zbox3.zebra
{
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zbox3.zebra.zimage.ZimageLargeC3;
	import azura.banshee.zbox3.zebra.zimage.ZimageSmallC3;
	import azura.banshee.zbox3.zebra.zmatrix.ZhlineC3;
	import azura.banshee.zbox3.zebra.zmatrix.ZmatrixC3;
	import azura.banshee.zbox3.zebra.zmatrix.ZvlineC3;
	import azura.banshee.zebra.Zebra3;
	import azura.banshee.zebra.branch.ZHline2;
	import azura.banshee.zebra.branch.ZVline2;
	import azura.banshee.zebra.branch.Zblank2;
	import azura.banshee.zebra.branch.ZimageLarge2;
	import azura.banshee.zebra.branch.ZimageSmall2;
	import azura.banshee.zebra.branch.Zmatrix2;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4;
	
	import org.osflash.signals.Signal;
	
	public class ZebraC3 extends Zbox3Container implements Zbox3ControllerI,LoopControlI
	{
		private var opDisplaying:Zbox3Container;
		public var zebra:Zebra3;
		private var mc5Old:String;
		
		public var onDisplay:Signal=new Signal();
		public var onCycleEnd:Signal=new Signal();
		
		public function ZebraC3(parent:Zbox3)
		{
			super(parent);
		}
		
		public function set fps(value:int):void{
			if(opDisplaying is ZhlineC3){
				ZhlineC3(opDisplaying).fps=value;
			}else if(opDisplaying is ZmatrixC3){
				ZmatrixC3(opDisplaying).fps=value;
			}
		}
		
		override public function notifyInitialized():void{
			super.notifyInitialized();
			onDisplay.dispatch();
		}
		
		override public function notifyClear():void{
			opDisplaying=null;
		}
		
		public function clear():void{
			mc5Old=null;
			zbox.clear();
		}
		
		public function feedMc5(mc5:String):Boolean{
			if(mc5==mc5Old)
				return false;
//			trace("mc5 change from",mc5Old,"to",mc5,this);
			mc5Old=mc5;
			var data:ZintBuffer=Gal4.readSync(mc5);
			feedData(data);
			return true;
		}
		
		public function feedData(data:ZintBuffer):void{
			data.uncompress();
			var zebra:Zebra3=new Zebra3();
			zebra.fromBytes(data);
			this.feedZebra(zebra);
			zbox.touchDX=-zebra.boundingBox.xc;
			zbox.touchDY=-zebra.boundingBox.yc;
		}
		
		public function feedZebra(zebra:Zebra3):void{
			this.zebra=zebra;
			
			if(!(zebra.branch is Zblank2)){
				zbox.width=zebra.boundingBox.width;
				zbox.height=zebra.boundingBox.height;
			}
			
			if(zebra.branch is Zblank2){
				zbox.clear();
			}else if(zebra.branch is ZimageSmall2){
				if(!(opDisplaying is ZimageSmallC3)){
					if(opDisplaying!=null)
						opDisplaying.zbox.dispose();
					opDisplaying=new ZimageSmallC3(this.zbox);
				}
				ZimageSmallC3(opDisplaying).feed(zebra.branch as ZimageSmall2);
			}else if(zebra.branch is ZimageLarge2){
				if(!(opDisplaying is ZimageLargeC3)){
					if(opDisplaying!=null)
						opDisplaying.zbox.dispose();
					opDisplaying=new ZimageLargeC3(this.zbox);
				}
				ZimageLargeC3(opDisplaying).feed(zebra.branch as ZimageLarge2);
			}else if(zebra.branch is ZHline2){
				if(!(opDisplaying is ZhlineC3)){
					if(opDisplaying!=null)
						opDisplaying.zbox.dispose();
					opDisplaying=new ZhlineC3(this.zbox,this);
				}
				var h:ZHline2=zebra.branch as ZHline2;
				ZhlineC3(opDisplaying).feed(h.line);
				ZhlineC3(opDisplaying).fps=h.fps;
			}else if(zebra.branch is ZVline2){
				if(!(opDisplaying is ZvlineC3)){
					if(opDisplaying!=null)
						opDisplaying.zbox.dispose();
					opDisplaying=new ZvlineC3(this.zbox);
				}
				var v:ZVline2=zebra.branch as ZVline2;
				ZvlineC3(opDisplaying).feed(v.line);
			}else if(zebra.branch is Zmatrix2){
				if(!(opDisplaying is ZmatrixC3)){
					if(opDisplaying!=null)
						opDisplaying.zbox.dispose();
					opDisplaying=new ZmatrixC3(this.zbox,this);
				}
				ZmatrixC3(opDisplaying).feed(zebra.branch as Zmatrix2);
			}else{
				trace("======= error: unkown format =======",this);
			}
		}
		
		public function restartCycle():void{
			if(opDisplaying is LoopControlI)
				LoopControlI(opDisplaying).restartCycle();
		}
		
		public function set loop(value:Boolean):void{
			if(opDisplaying is LoopControlI)
				LoopControlI(opDisplaying).loop=value;
		}
	}
}
