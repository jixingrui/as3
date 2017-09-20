package azura.common.old
{
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.events.Event;
	
	public class Stage3DShell
	{
		private var stage:Stage;
		public var stage3D:Stage3D;
		private var layerList:Vector.<Stage3DLayerOld>;
		
		private var initialized:Boolean;
		
		public function Stage3DShell(stage:Stage,... layers)
		{
			this.stage=stage;
			layerList=new Vector.<Stage3DLayerOld>(layers.length);
			for (var i:uint = 0; i < layers.length; i++) {
				layerList[i]=layers[i];
			}
			
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, contextCreatedHandler);
//			stage3D.requestContext3D("auto", "baselineConstrained");
			stage3D.requestContext3D();
		}
		
		private function contextCreatedHandler(event:Event):void {
			
			//			stage3D.context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, true);
			trace("context created");
			stage3D.context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, true);
			
			if(!initialized){
				initialized=true;
				stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
				
				for each(var l1:Stage3DLayerOld in layerList){
					l1.boot(stage,stage3D);
				}
				
			}
			
			for each(var l2:Stage3DLayerOld in layerList){
				l2.reboot();
			}
		}
		
		
		private function onEnterFrame(event:Event):void{
			
			if(stage3D.context3D==null)
			{trace("stage3D is null");
				return;
			}
			
			stage3D.context3D.clear();
			
			for each(var layer:Stage3DLayerOld in layerList){
				if(layer.active)
					layer.update();
			}			
			stage3D.context3D.present();
		}
	}
}