package azura.banshee.zebra.data.wrap
{
	import azura.banshee.zebra.data.Zframe2Data;
	
	import starling.textures.Texture;
	
	
	public class Zframe2 extends Zframe2Data implements Zframe2I
	{
		public var sheet:Zsheet2;
		
		private var listenerList:Vector.<Zframe2ListenerI>=new Vector.<Zframe2ListenerI>();
		
		private var idle_loading_loaded:int=0;
		public var nativeTexture_:Object;
		
		public var idxInAtlas:int;
		
		public var vip:Boolean;
		
		internal function sheetLoaded():void{
			if(idle_loading_loaded==1){
				loadFrameFromSheet();
			}
		}
		
		internal function get usingSheet():Boolean{
			return idle_loading_loaded>0;
		}
		
		public function frameLoaded():void{
			idle_loading_loaded=2;
			for each(var listener:Zframe2ListenerI in listenerList){
				listener.notifyZframe2Loaded();
			}
		}
		
		public function get nativeTexture():Object{
			return nativeTexture_;
		}
		
		public function get dx():Number{
			return anchor.x;
		}
		
		public function get dy():Number{
			return anchor.y;
		}
		
		public function get width():Number{
			return rectOnSheet.width;
		}
		
		public function get height():Number{
			return rectOnSheet.height;
		}
		
		public function startUse(listener:Zframe2ListenerI):void{
//			trace("start use",idxInAtlas,this);
			
			if(blank_key_delta==0){
				idle_loading_loaded=2;
				listener.notifyZframe2Loaded();
				return;
			}
			
			if(listenerList.indexOf(listener)!=-1)
				throw new Error();
			listenerList.push(listener);
			
			if(idle_loading_loaded==0){
				idle_loading_loaded=1;
				sheet.startUse(this);
			}else if(idle_loading_loaded==2)
				listener.notifyZframe2Loaded();
		}
		
		public function endUse(listener:Zframe2ListenerI):void{
//			trace("end use",idxInAtlas,this);
			if(blank_key_delta==0){
				idle_loading_loaded=0;
				listener.notifyZframe2Loaded();
				return;
			}
			
			var idx:int=listenerList.indexOf(listener);
			if(idx==-1)
				throw new Error();
			listenerList.splice(idx,1);
			
			if(listenerList.length==0){
				if(idle_loading_loaded==2)
					unloadFrameFromSheet();
				idle_loading_loaded=0;
				nativeTexture_=null;
				sheet.endUse(this);
			}
		}
		
		//================== loader task ===============
		public function loadFrameFromSheet():void
		{
			if(nativeTexture!=null)
				throw new Error();
			
			if(sheet.sheetTexture==null)
				throw new Error();
			
			if(blank_key_delta==1){			
				var sheetT:Texture=sheet.sheetTexture as Texture;
				if(rectOnSheet.x<0||rectOnSheet.y<0||
					(rectOnSheet.x+rectOnSheet.width)>sheetT.width||
					(rectOnSheet.y+rectOnSheet.height)>sheetT.height){
					throw new Error("texture size overflow");
				}
				nativeTexture_=Texture.fromTexture(sheetT,rectOnSheet);
				if(nativeTexture_==null)
					throw new Error();
			}
			
			frameLoaded();
		}
		
		public function unloadFrameFromSheet():void
		{
			if(blank_key_delta==1){
				Texture(nativeTexture).dispose();
				nativeTexture_=null;
			}
		}
	}
}