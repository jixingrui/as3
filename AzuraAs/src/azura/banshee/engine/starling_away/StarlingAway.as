package azura.banshee.engine.starling_away
{
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.events.Stage3DEvent;
	
	import azura.common.algorithm.mover.EnterFrame;
	import azura.common.algorithm.mover.TimerFps;
	import azura.touch.TouchStage;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class StarlingAway
	{
		private static var stage3DManager : Stage3DManager;
		private static var stage3DProxy : Stage3DProxy;
		
		private static var layerList:Vector.<Stage3DLayerI2>=new Vector.<Stage3DLayerI2>();		
		public static var stage:Stage;
		private static var onInit:Function;
		private static var holder:DisplayObjectContainer;
		
		private static var initialized:Boolean;
		
		public static function init(stage_:Stage,holder_:DisplayObjectContainer,onInit_:Function=null):void
		{
			if(stage!=null)
				throw new Error("StarlingAway: already initialized");
			
			stage=stage_;
			holder=holder_;
			onInit=onInit_;
			
			TouchStage.start(stage_);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode =  StageScaleMode.NO_SCALE;
			
			stage3DManager = Stage3DManager.getInstance(stage);
			stage3DProxy = stage3DManager.getFreeStage3DProxy(false,"baseline");
//			stage3DProxy = stage3DManager.getFreeStage3DProxy(false,Context3DProfile.BASELINE_EXTENDED);
			stage3DProxy.color=0x00333333;
			//			stage3DProxy.color=0xffffff;
//			stage3DProxy.antiAlias=4;
			stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
		}
		
		public static function set bgColor(value:uint):void{
			stage3DProxy.color=value;
		}
		
		private static function onContextCreated(event : Stage3DEvent) : void {
			if(!initialized){
				initialized=true;
				stage.addEventListener(Event.RESIZE,onResize);
				//				stage3DProxy.context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, true,true);
				stage3DProxy.addEventListener(Event.ENTER_FRAME,onEnterFrame);
				onInit.call();
			}
		}
		
		private static function onEnterFrame(event : Event) : void {
			
			TimerFps.tick();
			EnterFrame.tick();
			
			if(stage3DProxy.context3D==null){
				trace("context 3d not ready","StarlingAway");
				return;
			}
			
			//start
			for each(var layer:Stage3DLayerI2 in layerList){
				layer.enterFrame();
			}
		}
		
		public static function addStarlingLayer(ready_StarlingLayer:Function):void{
			var sl:StarlingLayer=new StarlingLayer();
			layerList.push(sl);
			sl.init(stage,stage3DProxy,ready_StarlingLayer);
		}
		
		public static function addAwayLayer():AwayLayer{
			var al:AwayLayer=new AwayLayer();
			al.init(stage3DProxy,holder);
			layerList.push(al);
			return al;
		}
		
		private static function onResize(event : Event) : void {
			if(stage.stageWidth==0||stage.stageHeight==0)
				return;
			
			if (stage3DProxy.stage3D == null) {
				return;
			}           
			if (stage3DProxy.context3D == null) {
				return;
			}
			if (stage3DProxy.context3D.driverInfo == "Disposed") {
				return;
			}
			
			stage3DProxy.width=stage.stageWidth;
			stage3DProxy.height=stage.stageHeight;
			
			for each(var layer:Stage3DLayerI2 in layerList){
				layer.resize(stage.stageWidth,stage.stageHeight);
			}
		}
		
		public static function reset():void{
			stage3DProxy.context3D.dispose(true);
		}
	}
}