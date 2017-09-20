package azura.common.old
{
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.events.Stage3DEvent;
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class Stage3DRootOld
	{
		private var stage3DManager : Stage3DManager;
		private var stage3DProxy : Stage3DProxy;
		
		private var layerList:Vector.<Stage3DLayerIOld>;		
		private var initialized:Boolean;
		private var stage:Stage;
		private var lastActive:Boolean;
		
		/**
		 * 
		 * @param layers:Layer3D
		 * 
		 */
		public function Stage3DRootOld(stage:Stage,... layers)
		{
			this.stage=stage;
			layerList=new Vector.<Stage3DLayerIOld>(layers.length);
			for (var i:uint = 0; i < layers.length; i++) {
				layerList[i]=layers[i];
			}
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode =  StageScaleMode.NO_SCALE;
			
			stage3DManager = Stage3DManager.getInstance(stage);
			stage3DProxy = stage3DManager.getFreeStage3DProxy(false,"baselineConstrained");
			stage3DProxy.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(event : Event) : void {
			//			trace("AwayShell: context created");
			if(!initialized){
				initialized=true;
				stage.addEventListener(Event.RESIZE,onResize);
				stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
				
				for each(var l1:Stage3DLayerIOld in layerList){
					l1.boot(stage3DProxy);
				}
				
			}else{
				
				for each(var l2:Stage3DLayerIOld in layerList){
					l2.reboot();
				}
			}
			
		}
		
		private function onResize(event : Event) : void {
			if(stage.stageWidth==0||stage.stageHeight==0)
				return;
			
			stage3DProxy.context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, true);
			stage3DProxy.width=stage.stageWidth;
			stage3DProxy.height=stage.stageHeight;
			for each(var layer:Stage3DLayerIOld in layerList){
				layer.resize(stage.stageWidth,stage.stageHeight);
			}	     
			//			reset();
		}
		
		private function onEnterFrame(event : Event) : void {
			//			trace("frame"+Math.random());
			if(stage3DProxy.context3D==null)
				return;
			
			stage3DProxy.context3D.clear();
			
			var active:Boolean=false;
			for (var i:int=0;i<layerList.length;i++){
				var layer:Stage3DLayerIOld=layerList[i];
				active||=layer.active;
				if(layer.active)
					layer.enterFrame();
			}
			
//			if(active||lastActive){
//				stage3DProxy.context3D.present();
//			}else{
//				stage3DProxy.context3D.present();
//			}
			stage3DProxy.present();
			
			lastActive=active;
		}
		
		public function reset():void{
			stage3DProxy.context3D.dispose();
		}
	}
}