package azura.banshee.layers.zpano 
{
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.core.pick.PickingCollisionVO;
	import away3d.core.pick.RaycastPicker;
	import away3d.entities.Mesh;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	
	import azura.banshee.door.RoomWithDoors;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.a3d.A3dLayer;
	import azura.mouse.MouseDUMI;
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.alert.Toast;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	public class LayerZpanoPure implements Stage3DLayerI
	{
		protected var al:A3dLayer;
		public var stage:Stage;
		
		private var this_:LayerZpano;
		private var bgLayer:ObjectContainer3D;
		
		//bg		
		private var cubeTexture:BitmapCubeTexture;
		private var _skyBox:SkyBox; 
		private var mc53:Vector.<String>;
		private var img6:Vector.<BitmapData>;
		private var currentSize:int;
		
		//navigation
		private var dragging:Boolean;
		private var downPanAngle:Number=0;
		private var downTiltAngle:Number=0;
		private var downMouseX:Number=0;
		private var downMouseY:Number=0;
		private var mouseX:Number=0;
		private var mouseY:Number=0;
		
		//mouse
		private var mouse:MouseDragScreen;
		
		public var tiltSpeed:Number=0.5;
		
		public function LayerZpanoPure(al:A3dLayer){
			this.al=al;
			stage=Stage3DRoot.singleton().stage;
			Stage3DRoot.singleton().addLayer(this);
			
			mouse=new MouseDragScreen(this);
		}
		
		public function init(stage:Stage):void{
			bgLayer=new ObjectContainer3D();
			al.view.scene.addChild(bgLayer);
			al.view.camera.lens = new PerspectiveLens (90);  
		}
		
		public function enterFrame():void{
			if (dragging)
			{
				al.camera.panAngle = (-0.2 * (mouseX - downMouseX) + downPanAngle);
				al.camera.tiltAngle = (-0.2 * (mouseY - downMouseY) * tiltSpeed + downTiltAngle);
			}
			al.enterFrame();
		}
		
		public function mouseDown(x:int,y:int):void{
			mouseX=x;
			mouseY=y;
			downMouseX = x;
			downMouseY = y;
			
			dragging = true;
			downPanAngle = al.camera.panAngle;
			downTiltAngle = al.camera.tiltAngle;
		}
		
		public function mouseMove(x:int,y:int):void{
			mouseX=x;
			mouseY=y;
		}
		
		public function mouseMoveDelta(dx:int,dy:int):void{
			dragging=true;
			mouseX+=dx;
			mouseY+=dy;
		}
		
		public function mouseUp(x:int,y:int):void{
			dragging=false;
//			trace("mouse up",this);
		}
		
		public function boot(rd:RoomWithDoors,x:int,y:int):void{
			mc5Scene=rd.room.mc5;
			lookAt(x,y);
		}
		
		public function set mc5Scene(value:String):void{
//			trace("load scene",this);
			Gallerid.singleton().getData(value).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				
				currentSize=0;
				img6=new Vector.<BitmapData>(6);
				mc53=new Vector.<String>();
				var data:ZintBuffer=item.dataClone();
				for(var j:int=0;j<3;j++){
					mc53.push(data.readUTF());
				}
				
				stepLoading();
			}
		}
		
		private function stepLoading():void{
			//			trace("step loading",this);
//			Toast.show("加载中...");
			img6=new Vector.<BitmapData>(6);
			Gallerid.singleton().getData(mc53[currentSize]).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				
				var data:ZintBuffer=item.dataClone();
				
				for(var i:int=0;i<6;i++){
					new ZpanoLoader(mc53[currentSize],i,data.readBytesZ()).load(onBitmapReady);
				}						
			}
			function onBitmapReady(ll:ZpanoLoader):void{
				//				trace("step ready",this);
				img6[ll.direction]=ll.value as BitmapData;
				check6();
			}
		}
		
		private function check6():void{
			var all:Boolean=true;
			for(var i:int=0;i<6;i++){
				if(img6[i]==null)
					all=false;
			}
			
			if(all){
				//				trace("skybox ready",this);
				
				clearSky();
				
				cubeTexture=new BitmapCubeTexture(img6[0],img6[1],img6[2],img6[3],img6[4],img6[5]);
				_skyBox = new SkyBox(cubeTexture);
				
				bgLayer.addChild(_skyBox);
				
				if(currentSize<2){
					currentSize++;
					stepLoading();
				}else{
					Toast.remove();
				}
			}
		}
		
		private function clearSky():void{
			dragging=false;
			if(_skyBox!=null){
				bgLayer.removeChild(_skyBox);
				_skyBox.dispose();
				_skyBox=null;
				cubeTexture.dispose();
			}
		}
		
		public function clear():void{
		}
		
		public function dispose():void{
			clearSky();
			bgLayer.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function lookAt(x:int,y:int):void{
			al.camera.tiltAngle=x;
			al.camera.panAngle=y;
		}
	}
}