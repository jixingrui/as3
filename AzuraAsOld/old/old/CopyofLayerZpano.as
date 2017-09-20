package azura.avalon.ice.layers 
{
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.controllers.FirstPersonController;
	import away3d.controllers.HoverController;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.Trident;
	import away3d.entities.Mesh;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.ColorMaterial;
	import away3d.materials.SkyBoxMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.materials.methods.EnvMapMethod;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.SkyBox;
	import away3d.textures.ATFCubeTexture;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.BitmapTexture;
	import away3d.textures.CubeTextureBase;
	
	import azura.avalon.mouse.MouseClickTargetI;
	import azura.avalon.mouse.MouseDragTargetI;
	import azura.avalon.mouse.MouseManager;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Point3;
	import azura.common.stage3d.Stage3DLayer;
	import azura.common.util.OS;
	import azura.gallerid.gal.Gal;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import mx.states.AddChild;
	
	import org.osflash.signals.Signal;
	
	public class CopyofLayerZpano extends Stage3DLayer implements MouseDragTargetI
	{
		private var this_:LayerZpano;
		private var holder:DisplayObjectContainer;
		protected var _view:View3D;		
		private var camera:FirstPersonController;
		private var _hud:View3D;		
		private var bgLayer:ObjectContainer3D;
		
		//bg		
		private var _skyBox:SkyBox; 
		private var data33:Vector.<Vector.<String>>;
//		private var loader:Gal_Http2;
		private var currentSize:int;
		
		//navigation
		private var moving:Boolean;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		
		//pos
		private var xyz:Point3;
		
		public function CopyofLayerZpano(stage:Stage,holder:DisplayObjectContainer){
			super(stage);
			this.holder=holder;			
			this.active=false;
			this_=this;
		}
		
		override public function resize(width:int, height:int):void{
			_view.width=width;
			_view.height=height;
		}
		
		override public function boot(proxy:Stage3DProxy):void {
			
			Parsers.enableAllBundled();
			
			_view = new View3D();
			_view.stage3DProxy=proxy;
			_view.shareContext=true;
			holder.addChild(_view);
			
			_view.camera.lens.far = 14000;
			_view.camera.lens.near = 1;
			_view.camera.x=0;
			_view.camera.y=0;
			_view.camera.z=0;
			
			camera = new FirstPersonController(_view.camera, 0, 0, -90, 90);
			camera.steps=0;
			
			bgLayer=new ObjectContainer3D();
			_view.scene.addChild(bgLayer);
	
			
//			arrow=new Arrow(stage);
//			arrow.load(onLoaded);			
			
			initListeners();
			initItems();
		}
		
		protected function initItems():void{
			
		}
		
		protected function getView(tile:Number,pan:Number):void{
			
		}
		
		protected function setView(tilt:Number,pan:Number):void{
			camera.tiltAngle=tilt;
			camera.panAngle=pan;
		}
		
		private function initListeners():void 
		{
			stage.addEventListener(Event.EXIT_FRAME, MouseManager.singleton().exitFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			function onMouseDown(event:MouseEvent):void
			{
				MouseManager.singleton().mouseDown(this_,stage.mouseX,stage.mouseY);
			}
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			function onMouseMove(event:MouseEvent):void
			{
				MouseManager.singleton().mouseMove(this_,stage.mouseX,stage.mouseY);
			}
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			function onMouseUp(event:MouseEvent):void
			{
				MouseManager.singleton().mouseUp(this_,stage.mouseX,stage.mouseY);
			}
		} 
		
		override public function enterFrame():void{
			if (moving)
			{
				camera.panAngle = -0.2 * (stage.mouseX - lastMouseX) + lastPanAngle;
				camera.tiltAngle = -0.05 * (stage.mouseY - lastMouseY) + lastTiltAngle;
				
				xyz=FastMath.tprToxyz(camera.tiltAngle,camera.panAngle,1000);
//				var tpr:Point3=new Point3(cameraController.tiltAngle,cameraController.panAngle,1000);
				
				getView(camera.tiltAngle,camera.panAngle);
//				getView(xyz);
//				arrow.mesh.x=xyz.x;
//				arrow.mesh.y=xyz.y;
//				arrow.mesh.z=xyz.z;
			}
			_view.render();
		}
		
		public function showPano(md5:String):void{
			active=true;
			currentSize=0;
//			new Gal_Http2(md5).load(onReady);
			Gal.getData(md5,onReady);
			function onReady(ba:ByteArray):void{
//			function onReady(gh:Gal_Http2):void{
				
//				var zb33:ZintBuffer=gh.value as ZintBuffer;
				var zb33:ZintBuffer=new ZintBuffer(ba);
				data33=new Vector.<Vector.<String>>();
				for(var i:int=0;i<3;i++){
					data33.push(new Vector.<String>);
					for(var j:int=0;j<3;j++){
						data33[i].push(zb33.readUTF());
					}
				}
				
				stepLoading();
			}
		}
		
		private function stepLoading():void{
			if(!active||currentSize>2)
				return;
			
			var key:String=data33[OS.ordinal][currentSize];
			
			setTimeout(loadData,100,key);
		}
		
		private function loadData(key:String):void{
//			loader=new Gal_Http2(key);
//			loader.load(onDataReady);
			Gal.getData(key,onDataReady);
			function onDataReady(ba:ByteArray):void{
				setTimeout(show,0,ba);
			}
		}
		
		private function show(data:ByteArray):void{
			if(!active){
				return;
			}
			
			data=new ZintBuffer(data);	
			data.uncompress();
			
			if(_skyBox!=null)
				unload();
			
			currentSize++;
			var cubeTexture:ATFCubeTexture=new ATFCubeTexture(data);
			_skyBox = new SkyBox(cubeTexture);
			bgLayer.addChild(_skyBox);
			
			setTimeout(stepLoading,1000*FastMath.pow2(currentSize));
		}
		
		private function unload():void{
			moving=false;
			if(_skyBox!=null){
				bgLayer.removeChild(_skyBox);
				_skyBox.dispose();
				_skyBox=null;
			}
		}
		
		public function clear():void{
//			if(loader!=null){
//				loader.release(0);
//			}
			active=false;
			unload();
		}
		
		public function get priority():int{
			return 0;
		}
		
		public function dragStart(x:int, y:int):void
		{
			moving = true;
		}
		
		public function dragMove(x:int, y:int):void
		{
			lastPanAngle = camera.panAngle;
			lastTiltAngle = camera.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
		}
		
		public function dragEnd(x:int, y:int):void
		{
			moving = false;
		}
		
	}
}