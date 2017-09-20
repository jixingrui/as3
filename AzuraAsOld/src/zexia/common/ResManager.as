package zexia.common
{
	import azura.common.ui.shine.ShineButtonLoaderI;
	
	import com.deadreckoned.assetmanager.Asset;
	import com.deadreckoned.assetmanager.AssetManager;
	import com.deadreckoned.assetmanager.events.AssetEvent;
	
	import flash.display.BitmapData;
	
	import org.osflash.signals.Signal;
	
	public class ResManager implements ShineButtonLoaderI
	{
		public function loadBitmapData(url:String):BitmapData
		{
			var asset:Asset=AssetManager.getInstance().get(url);
			if(asset==null)
				throw new Error("Error: asset not found "+url);
			else
				return asset.asset;
		}
		
		private static var am:AssetManager;
		
		public static var allReady:Boolean;
		public static var onReady:Signal=new Signal();
		public static function initAssets():void{
			AssetManager.verbose=true;
			am=AssetManager.getInstance();
			am.addEventListener(AssetEvent.QUEUE_COMPLETE,onQueueComplete);
			
			loadBg();
			loadBanner();
			loadButton();
			loadPlayer();
			loadChange();
			loadMisc();
		}
		
		private static function loadMisc():void{			
			am.add("zzz/common/dot/dot.png");
			am.add("zzz/common/dot/b/dot.png");
			
			am.add("zzz/common/dot/red.png");
			
			loadLoop("zzz/common/dot/shine/",1,4,".png",false);
			
			am.add("zzz/common/back/back.png");
			am.add("zzz/common/back/b/back.png");
			
			am.add("zzz/common/pano/btn/touch.png");
			am.add("zzz/common/pano/btn/gravity.png");
			
//			am.add("zzz/common/save/saved.png");
		}
		
		private static function loadBg():void{
			am.add("zzz/common/bg/p1.jpg");
			am.add("zzz/common/bg/logo.jpg");
			am.add("zzz/common/bg/frame.jpg");
//			am.add("zzz/p1p1p4/bg.jpg");
			am.add("zzz/p1p3p1p2/blank.png");
			am.add("zzz/p1p4/bg.jpg");;
			am.add("zzz/p1p7/circle.png");;
			am.add("zzz/p1p8/bg.jpg");
		}
		
		private static function loadBanner():void{
			am.add("zzz/p1p1/banner.png");
			am.add("zzz/p1p1p1/banner.png");
			am.add("zzz/p1p1p2/banner.png");
			am.add("zzz/p1p1p3/banner.png");
			am.add("zzz/p1p1p4/banner.png");
			am.add("zzz/p1p2/banner.png");
			am.add("zzz/p1p3/banner.png");
			am.add("zzz/p1p3p1/banner.png");
			am.add("zzz/p1p3p1p1/banner.png");
			am.add("zzz/p1p3p1p2/banner.png");
			am.add("zzz/p1p3p2/banner.png");
			am.add("zzz/p1p4/banner.png");
			am.add("zzz/p1p5/banner.png");
			am.add("zzz/p1p6/banner.png");
			am.add("zzz/p1p7/banner.png");
			am.add("zzz/p1p8/banner.png");
		}
		
		private static function loadButton():void{						
			
			loadLoop("zzz/p1p3/save/btn/",1,1,".png",true);
			loadLoop("zzz/p1p7p1/print/btn/",1,1,".png",true);
			
			loadLoop("zzz/p1/btn/",1,8,".png",true);
			loadLoop("zzz/p1/bg/",1,5,".png",true);
			loadLoop("zzz/p1p1/btn/",1,5,".png",true);
			loadLoop("zzz/p1p1p1/btn/",1,2,".png",true);
			loadLoop("zzz/p1p1p2/btn/",1,3,".png",true);
			loadLoop("zzz/p1p1p3/btn/",1,4,".png",true);
			loadLoop("zzz/p1p1p4/btn/",1,5,".png",true);
			loadLoop("zzz/p1p2/btn/",1,5,".png",true);
			loadLoop("zzz/p1p2p1/btn/",1,5,".png",true);
			loadLoop("zzz/p1p2p1p1/btn/",1,7,".png",true);
			loadLoop("zzz/p1p2p2/btn/",1,5,".png",true);
			loadLoop("zzz/p1p2p2p1/btn/",1,6,".png",true);
			loadLoop("zzz/p1p2p3/btn/",1,4,".png",true);
			loadLoop("zzz/p1p2p3p1p1/btn/",1,5,".png",true);
			loadLoop("zzz/p1p2p3p1p2/btn/",1,4,".png",true);
			loadLoop("zzz/p1p2p4p1p1/btn/",1,4,".png",true);
			loadLoop("zzz/p1p2p4p1p2/btn/",1,4,".png",true);
			loadLoop("zzz/p1p2p4/btn/",1,4,".png",true);
			loadLoop("zzz/p1p2p4p1/btn/",1,8,".png",true);
			loadLoop("zzz/p1p2p5/btn/",1,4,".png",true);
			loadLoop("zzz/p1p2p5p1/btn/",1,7,".png",true);
			loadLoop("zzz/p1p3/btn/",1,2,".png",true);
			loadLoop("zzz/p1p3p1/btn/",1,2,".png",true);
			loadLoop("zzz/p1p3p1p1/btn/",1,6,".png",true);
			loadLoop("zzz/p1p3p2/btn/",1,3,".png",true);
			loadLoop("zzz/p1p4/btn/",1,8,".png",true);
			loadLoop("zzz/p1p5/btn/",1,1,".png",true);
			loadLoop("zzz/p1p5/list/",1,12,".png",true);
			loadLoop("zzz/p1p5p13/page/",1,5,".png",false);
			loadLoop("zzz/p1p6/btn/",1,1,".png",false);
			loadLoop("zzz/p1p7/btn/",1,3,".png",true);
			loadLoop("zzz/p1p7/bg/",1,3,".png",true);
			loadLoop("zzz/p1p7p1p1/btn/",1,6,".png",true);
			loadLoop("zzz/p1p7p1p2/btn/",1,6,".png",true);
			loadLoop("zzz/p1p7p1p3/btn/",1,4,".png",true);
			loadLoop("zzz/p1p7p1p4/btn/",1,3,".png",true);
			loadLoop("zzz/p1p7p2/page/",1,3,".png",false);
			loadLoop("zzz/p1p7p3/page/",1,2,".png",false);
			loadLoop("zzz/p1p8/btn/",1,6,".png",true);
			loadLoop("zzz/p1p8/btnMap/",1,5,".png",true);
			loadLoop("zzz/p1p8/text/",1,6,".png",false);
			loadLoop("zzz/p1p8/HD/",1,6,".png",false);
		}
		
		private static function loadPlayer():void{
			am.add("zzz/common/player/play.png");
			am.add("zzz/common/player/pause.png");
			am.add("zzz/common/player/close.png");
			am.add("zzz/common/player/prev.png");
			am.add("zzz/common/player/next.png");
			
			am.add("zzz/common/player/b/play.png");
			am.add("zzz/common/player/b/pause.png");
			am.add("zzz/common/player/b/close.png");
			am.add("zzz/common/player/b/prev.png");
			am.add("zzz/common/player/b/next.png");
		}
		
		private static function loadChange():void{
			
			//inside
			loadLoop("zzz/p1p3p1p2/btn/",1,5,".png",true);	
//			loadLoop("zzz/p1p3p1p2/blank/",1,2,".png",false);	
			
			loadLoop("zzz/p1p3p1p2/menu/1top/btn/",1,8,".png",true);	
			loadLoop("zzz/p1p3p1p2/menu/1top/part/",0,8,".png",false);
			
			loadLoop("zzz/p1p3p1p2/menu/2cop/btn/",1,7,".png",true);	
			loadLoop("zzz/p1p3p1p2/menu/2cop/part/",0,7,".png",false);
			
			loadLoop("zzz/p1p3p1p2/menu/3tiao/btn/",1,17,".png",true);	
			loadLoop("zzz/p1p3p1p2/menu/3tiao/part/",0,17,".png",false);
			
			loadLoop("zzz/p1p3p1p2/menu/4wall/btn/",1,14,".png",true);	
			loadLoop("zzz/p1p3p1p2/menu/4wall/part/",0,14,".png",false);
			
			loadLoop("zzz/p1p3p1p2/menu/5floor/btn/",1,6,".png",true);	
			loadLoop("zzz/p1p3p1p2/menu/5floor/part/",0,6,".png",false);
			
			//outside
			loadLoop("zzz/p1p3p2/blank/",1,1,".png",false);	
			
			//outside 1
			loadLoop("zzz/p1p3p2p1/btn/",1,4,".png",true);	
			
			loadLoop("zzz/p1p3p2p1/menu/1wall/btn/",1,5,".png",true);	
			loadLoop("zzz/p1p3p2p1/menu/1wall/part/",0,5,".png",false);
			
			loadLoop("zzz/p1p3p2p1/menu/2lop/btn/",1,7,".png",true);	
			loadLoop("zzz/p1p3p2p1/menu/2lop/part/",0,7,".png",false);
			
			loadLoop("zzz/p1p3p2p1/menu/3door/btn/",1,13,".png",true);	
			loadLoop("zzz/p1p3p2p1/menu/3door/part/",0,13,".png",false);
			
			loadLoop("zzz/p1p3p2p1/menu/4doorframe/btn/",1,14,".png",true);	
			loadLoop("zzz/p1p3p2p1/menu/4doorframe/part/",0,14,".png",false);
			
			//outside 2
			loadLoop("zzz/p1p3p2p2/btn/",1,4,".png",true);	
			
			loadLoop("zzz/p1p3p2p2/menu/1wall/btn/",1,5,".png",true);	
			loadLoop("zzz/p1p3p2p2/menu/1wall/part/",0,5,".png",false);
			
			loadLoop("zzz/p1p3p2p2/menu/2lop/btn/",1,7,".png",true);	
			loadLoop("zzz/p1p3p2p2/menu/2lop/part/",0,7,".png",false);
			
			loadLoop("zzz/p1p3p2p2/menu/3door/btn/",1,13,".png",true);	
			loadLoop("zzz/p1p3p2p2/menu/3door/part/",0,13,".png",false);
			
			loadLoop("zzz/p1p3p2p2/menu/4doorframe/btn/",1,14,".png",true);	
			loadLoop("zzz/p1p3p2p2/menu/4doorframe/part/",0,14,".png",false);
			
			//outside 3
			loadLoop("zzz/p1p3p2p3/btn/",1,4,".png",true);	
			
			loadLoop("zzz/p1p3p2p3/menu/1wall/btn/",1,5,".png",true);	
			loadLoop("zzz/p1p3p2p3/menu/1wall/part/",0,5,".png",false);
			
			loadLoop("zzz/p1p3p2p3/menu/2lop/btn/",1,11,".png",true);	
			loadLoop("zzz/p1p3p2p3/menu/2lop/part/",0,11,".png",false);
			
			loadLoop("zzz/p1p3p2p3/menu/3door/btn/",1,13,".png",true);	
			loadLoop("zzz/p1p3p2p3/menu/3door/part/",0,13,".png",false);
			
			loadLoop("zzz/p1p3p2p3/menu/4doorframe/btn/",1,14,".png",true);	
			loadLoop("zzz/p1p3p2p3/menu/4doorframe/part/",0,14,".png",false);
		}
		
		
		private static function loadLoop(head:String,start:int,end:int,tail:String,hasB:Boolean=false):void{
			for(var i:int=start;i<=end;i++){
				am.add(head+i+tail);
				if(hasB){
					am.add(head+"b/"+i+tail);
				}
			}
		}
		
		private static function onQueueComplete(e:AssetEvent):void{
			trace("all loaded");
			onReady.dispatch();
		}
		
	}
}