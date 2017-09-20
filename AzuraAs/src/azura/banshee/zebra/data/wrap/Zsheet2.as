package azura.banshee.zebra.data.wrap
{
	import azura.banshee.engine.starling_away.StarlingAtf2;
	import azura.banshee.engine.starling_away.StarlingAtf2Vip;
	import azura.banshee.zebra.data.Zsheet2Data;
	import azura.common.async2.AsyncLoader2;
	import azura.common.util.OS;
	import azura.gallerid4.Gal4PackI;
	
	public class Zsheet2 extends Zsheet2Data implements Gal4PackI
	{
		internal var atlas:Zatlas2;
		public var frameList:Vector.<Zframe2>=new Vector.<Zframe2>();
		
		private var idle_loading_loaded:int=0;
		
		private var loader:AsyncLoader2;
		public var sheetTexture:Object;
		
		internal function startUse(user:Zframe2):void{
			
			if(user.nativeTexture!=null)
				throw new Error();
			
			frameList.push(user);
			if(idle_loading_loaded==0){
				idle_loading_loaded=1;
				StarlingAtf2Vip.init();
				if(user.vip){
					loader=new StarlingAtf2Vip(me5ByPlatform);
				}else{
					loader=new StarlingAtf2(me5ByPlatform);
				}
				loader.load(atfLoaded);
			}else if(idle_loading_loaded==2){
				user.sheetLoaded();
			}
		}
		
		internal function endUse(user:Zframe2):void{
			var idx:int=frameList.indexOf(user);
			frameList.removeAt(idx);
			
			if(!inUse){
				idle_loading_loaded=0;
				loader.release(10000);
			}
		}
		
		private function atfLoaded(loader:AsyncLoader2):void{
			if(idle_loading_loaded!=1)
				throw new Error();
			if(loader.value==null)
				throw new Error();
			
			idle_loading_loaded=2;
			this.sheetTexture=loader.value;
			for each(var frame:Zframe2 in frameList){
				frame.sheetLoaded();
			}
		}
		
		internal function get inUse():Boolean{
			return frameList.length>0;
			//			for each(var frame:Zframe2 in frameList){
			//				if(frame.usingSheet){
			//					return true;
			//				}
			//			}
			//			return false;
		}
		
		//=================== me5 ===============
		public function get me5Original():String{
			return platformList[0];
		}
		
		public function get me5ByPlatform():String{
			if(OS.isPc)
				return platformList[1];
			else if(OS.isAndroid)
				return platformList[2];
			else if(OS.isIos)
				return platformList[3];
			else 
				throw new Error("Zsheet: unknown platform");
		}
		
		public function getMc5List(dest:Vector.<String>):void
		{
			for each(var me5:String in platformList){
				dest.push(me5);
			}
		}
	}
}
