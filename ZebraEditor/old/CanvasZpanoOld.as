package azura.banshee.maze.zpano 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.controllers.FirstPersonController;
	import away3d.core.managers.Stage3DProxy;
	import away3d.loaders.parsers.Parsers;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	
	import azura.avalon.mouse.MouseDummy;
	import azura.avalon.mouse.MouseManager;
	import azura.common.collections.ZintBuffer;
	import azura.common.stage3d.Stage3DLayer;
	import azura.gallerid.gal.Gal;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	public class CanvasZpanoOld extends Stage3DLayer
	{
		private var this_:CanvasZpanoOld;
		private var holder:DisplayObjectContainer;
		protected var _view:View3D;		
		private var camera:FirstPersonController;
		private var _hud:View3D;		
		private var bgLayer:ObjectContainer3D;
		
		//bg		
		private var cubeTexture:BitmapCubeTexture;
		private var _skyBox:SkyBox; 
		private var md53:Vector.<String>;
		private var img6:Vector.<BitmapData>;
		private var currentSize:int;
		
		//navigation
		private var dragging:Boolean;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		
		//pos
		//		private var xyz:Point3;
		
		public var itemLayer:ObjectContainer3D;
		
		private var dummy:MouseDummy=new MouseDummy();
		
		//		private var tri:Trident;
		
		public function CanvasZpanoOld(stage:Stage,holder:DisplayObjectContainer){
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
			
			
			//			tri=new Trident(100);
			//			_view.scene.addChild(tri);
			//			
			//			tri.x=0;
			//			tri.y=0;
			//			tri.z=300;
			//			tri.rotationX=0;
			//			tri.rotationY=0;
			//			tri.rotationZ=0;
			
			initListeners();
			initItems();
		}
		
		protected function initItems():void{
			itemLayer=new ObjectContainer3D();
			_view.scene.addChild(itemLayer);
			
		}
		
		public function get tilt():Number{
			return camera.tiltAngle;
		}
		
		public function get pan():Number{
			return camera.panAngle;
		}
		
		protected function setView(tilt:Number,pan:Number):void{
			camera.tiltAngle=tilt;
			camera.panAngle=pan;
		}
		
		private function initListeners():void 
		{
			
		} 
		
		override public function enterFrame():void{
			if (dragging)
			{
				camera.panAngle = -0.2 * (stage.mouseX - lastMouseX) + lastPanAngle;
				camera.tiltAngle = -0.05 * (stage.mouseY - lastMouseY) + lastTiltAngle;
			}
			_view.render();
		}
		
		public function showPano(md5:String):void{
			active=true;
			currentSize=0;
			img6=new Vector.<BitmapData>(6);
			for(var i:int=0;i<6;i++){
				img6[i]=new BitmapData(256,256,false,i*0x222222);
			}
			
			Gal.getData(md5,onReady);
			function onReady(ba:ByteArray):void{
				var zb:ZintBuffer=new ZintBuffer(ba);
				
				md53=new Vector.<String>();
				for(var j:int=0;j<3;j++){
					md53.push(zb.readUTF());
				}
				
				stepLoading();
			}
		}
		
		private function stepLoading():void{
			
			img6=new Vector.<BitmapData>(6);
			Gal.getData(md53[currentSize],onReady);
			function onReady(ba:ByteArray):void{
				var zb:ZintBuffer=new ZintBuffer(ba);
				
				for(var i:int=0;i<6;i++){
					new ZpanoLoader(md53[currentSize],i,zb.readBytes_()).load(onBitmapReady);;
				}						
			}
			function onBitmapReady(ll:ZpanoLoader):void{
				img6[ll.direction]=ll.value as BitmapData;
				check();
			}
		}
		
		private function check():void{
			if(!active){
				return;
			}
			
			var all:Boolean=true;
			for(var i:int=0;i<6;i++){
				if(img6[i]==null)
					all=false;
			}
			
			if(all){
				if(_skyBox!=null)
					unload();
				
				cubeTexture=new BitmapCubeTexture(img6[0],img6[1],img6[2],img6[3],img6[4],img6[5]);
				_skyBox = new SkyBox(cubeTexture);
				
				bgLayer.addChild(_skyBox);
				
				if(currentSize<2){
					currentSize++;
					stepLoading();
				}
			}
		}
		
		private function unload():void{
			dragging=false;
			if(_skyBox!=null){
				//				bgLayer.removeChild(_skyBox);
				cubeTexture.dispose();
				_skyBox.dispose();
				_skyBox=null;
			}
		}
		
		public function clear():void{
			//			if(loader!=null){
			//				loader.release(0);
			//			}
			active=false;
			itemLayer.disposeWithChildren();
			initItems();
			unload();
			
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function unclear():void{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function onMouseDown(event:MouseEvent):void
		{
			MouseManager.singleton().mouseDown(dummy,stage.mouseX,stage.mouseY);
			dragging = true;
			lastPanAngle = camera.panAngle;
			lastTiltAngle = camera.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
		}
		private function onMouseMove(event:MouseEvent):void
		{
			MouseManager.singleton().mouseMove(dummy,stage.mouseX,stage.mouseY);
		}
		private function onMouseUp(event:MouseEvent):void
		{
			MouseManager.singleton().mouseUp(dummy,stage.mouseX,stage.mouseY);
			dragging=false;
		}
	}
}