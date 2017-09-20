package com.helix.data
{
	import com.deadreckoned.assetmanager.AssetManager;
	import com.deadreckoned.assetmanager.AssetQueue;
	import com.deadreckoned.assetmanager.events.AssetEvent;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	public class Gallery
	{
		public var entrance:String;
		public var id_Helix:Dictionary=new Dictionary();
		
//		public var onChange:Signal=new Signal(Helix);
		private var onLoaded:Signal=new Signal(Gallery);
		
		private var am:AssetQueue;
		
		public function fromXml(xml:XML):Signal{
			var helix:Helix;
			entrance=xml.@entrance;
			
			var list:XMLList=new XMLList(xml.helix);
			for each(var hx:XML in list){
				helix=new Helix(this);
				helix.fromXml(hx);
				id_Helix[helix.id]=helix;
			}
			
			for each(helix in id_Helix){
				if(helix.isLeaf)
					continue;
				for each(var item:HelixItem in helix.itemList){
					var target:Helix=id_Helix[item.target];
					target.back=helix;
				}
			}
			
			return loadAssets();
		}
		
		private function loadAssets():Signal{
//			var am:AssetManager=AssetManager.getInstance();
			am=AssetManager.getInstance().createQueue();
			am.addEventListener(AssetEvent.QUEUE_COMPLETE,onComplete);
			for each(var helix:Helix in id_Helix){
				am.add(helix.urlTitle);
				for each(var item:HelixItem in helix.itemList){
					am.add(item.urlThumb);
					am.add(item.urlDetail);
				}
			}
			return onLoaded;
		}
		
		private function onComplete(ae:AssetEvent):void{
			am.removeEventListener(AssetEvent.QUEUE_COMPLETE,onComplete);
			onLoaded.dispatch(this);
		}
	}
}