package azura.banshee.engine
{
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	
	import azura.banshee.engine.a3d.A3dEngine;
	import azura.banshee.engine.g2d.G2dEngine;
	
	import com.genome2d.Genome2D;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	public class Stage3DRoot
	{
		private static var instance:Stage3DRoot = new Stage3DRoot();	
		public function Stage3DRoot() {			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" );
		}		
		
		public function get stage():Stage
		{
			return _stage;
		}
		
		public static function singleton():Stage3DRoot {			
			return instance;			
		}	
		
		private var stage3DManager : Stage3DManager;
		private var stage3DProxy : Stage3DProxy;
		
		private var layerList:Vector.<Stage3DLayerI>=new Vector.<Stage3DLayerI>();		
		private var initialized:Boolean;
		private var initDone:Boolean;
		private var _stage:Stage;
		private var onInit:Function;
		private var holder:DisplayObjectContainer;
		
		public function init(stage:Stage,holder:DisplayObjectContainer,onInit:Function=null):void
		{
			if(this._stage!=null)
				throw new Error("Stage3DRoot: already initialized");
			
			this._stage=stage;
			this.holder=holder;
			this.onInit=onInit;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode =  StageScaleMode.NO_SCALE;
			
			stage3DManager = Stage3DManager.getInstance(stage);
//			stage3DProxy = stage3DManager.getFreeStage3DProxy(false,Context3DProfile.BASELINE);
			stage3DProxy = stage3DManager.getFreeStage3DProxy(false,"baselineConstrained");
//			stage3DProxy = stage3DManager.getFreeStage3DProxy(false,"standard");
//			stage3DProxy = stage3DManager.getFreeStage3DProxy(false,Context3DProfile.STANDARD_CONSTRAINED);
//			trace(Context3DProfile.STANDARD_CONSTRAINED,this);
			stage3DProxy.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(event : Event) : void {
			if(!initialized){
				initialized=true;
				stage.addEventListener(Event.RESIZE,onResize);
				stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
				
				A3dEngine.singleton().init(holder,stage3DProxy);
				G2dEngine.singleton().init(stage,stage3DProxy.stage3D,onG2dInitialized);
			}
		}
		
		private function onG2dInitialized():void{
			
			for (var i:int=0;i<layerList.length;i++){
				var layer:Stage3DLayerI=layerList[i];
				layer.init(stage);
			}
			initDone=true;
			if(onInit!=null)
				onInit.call();
		}
		
		private function onResize(event : Event) : void {
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
			
			stage3DProxy.context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, true);
			stage3DProxy.width=stage.stageWidth;
			stage3DProxy.height=stage.stageHeight;
			
			G2dEngine.singleton().resize(stage.stageWidth,stage.stageHeight);
		}
		
		private var visible_:Boolean=true;
		public function set visible(value:Boolean):void{
			visible_=value;
			if(!visible_){
				stage3DProxy.context3D.clear();
				Genome2D.getInstance().update(0);
				stage3DProxy.present();		
			}
		}
		
		private function onEnterFrame(event : Event) : void {
			
			if(stage3DProxy.context3D==null||visible_==false)
				return;
			
			stage3DProxy.context3D.clear();
			Genome2D.getInstance().update(0);
			
			G2dEngine.singleton().enterFrame();
			
			//start
			for each(var layer:Stage3DLayerI in layerList){
				layer.enterFrame();
			}
			
			stage3DProxy.present();			
		}
		
		public function addLayer(layer:Stage3DLayerI):void{
			layerList.push(layer);
			if(initDone){
				setTimeout(layer.init,0,stage);
			}
//				layer.init(stage);
		}
		
		public function removeLayer(layer:Stage3DLayerI):void{
			layerList.splice(layerList.indexOf(layer),1);
		}
		
		public function reset():void{
			stage3DProxy.context3D.dispose();
		}
	}
}