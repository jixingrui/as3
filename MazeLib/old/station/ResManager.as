package assets.station
{
	
	import com.deadreckoned.assetmanager.AssetManager;
	import com.deadreckoned.assetmanager.AssetQueue;
	import com.deadreckoned.assetmanager.events.AssetEvent;
	
	import org.osflash.signals.Signal;
	
	public class ResManager
	{
//		private static var am:AssetManager;
		private static var am:AssetQueue;
		
		public static var allReady:Boolean;
		public static var onReady:Signal=new Signal();
		public static function initAssets():void{
//			am=AssetManager.getInstance();
			am=AssetManager.getInstance().createQueue();
			am.addEventListener(AssetEvent.QUEUE_COMPLETE,onQueueComplete);
			am.path="assets/";
			
//			loadLevelButton();
			loadIcon();
		}
		
		private static function loadIcon():void{
			am.add("station/start.zebra");
			am.add("station/arrow.zebra");
			am.add("station/end.zebra");
		}
		
//		private static function loadLevelButton():void{
//			am.add("station/f1.png");
//			am.add("station/f2.png");
//			am.add("station/f3.png");
//		}
		
		private static function onQueueComplete(e:AssetEvent):void{
			am.removeEventListener(AssetEvent.QUEUE_COMPLETE,onQueueComplete);
			onReady.dispatch();
		}
		
	}
}