package azura.banshee.layers.zpano 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.core.pick.PickingCollisionVO;
	import away3d.core.pick.RaycastPicker;
	import away3d.entities.Mesh;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	
	import azura.banshee.door.Door;
	import azura.banshee.door.RoomWithDoors;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.a3d.A3dLayer;
	import azura.mouse.MouseDUMI;
	import azura.banshee.zebra.i.ZmazeI;
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.alert.Toast;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class LayerZpano implements ZmazeI,MouseDUMI
	{
		protected var al:A3dLayer;
		protected var stage:Stage;
		
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
		private var downPanAngle:Number;
		private var downTiltAngle:Number;
		private var downMouseX:Number;
		private var downMouseY:Number;
		private var mouseX:int,mouseY:int;
		
		//item
		private var _onDoorClick:Signal=new Signal(Door);
		public var itemLayer:ObjectContainer3D;
		private var arrowList:Vector.<Arrow>=new Vector.<Arrow>();
		
		public function LayerZpano(al:A3dLayer){
			this.al=al;
			this_=this;
			stage=Stage3DRoot.singleton().stage;
			Stage3DRoot.singleton().addLayer(this);
		}
		
		public function init(stage:Stage):void{
			bgLayer=new ObjectContainer3D();
			al.view.scene.addChild(bgLayer);
			
			itemLayer=new ObjectContainer3D();
			al.view.scene.addChild(itemLayer);
		}
		
		public function get tilt():Number{
			return al.camera.tiltAngle;
		}
		
		public function get pan():Number{
			return al.camera.panAngle;
		}
		
		public function enterFrame():void{
			if (dragging)
			{
				al.camera.panAngle = (-0.2 * (mouseX - downMouseX) + downPanAngle)%360;
				al.camera.tiltAngle = (-0.05 * (mouseY - downMouseY) + downTiltAngle)%360;
			}
			al.enterFrame();
		}
		
		public function get mouse():MouseDUMI{
			return this;
		}
		
		public function get priority():int{
			return 0;
		}
		
		public function mouseDown(x:int,y:int):Boolean{
			mouseX=x;
			mouseY=y;
			downMouseX = x;
			downMouseY = y;
			
			//			trace("drag start",x,y,this);
			dragging = true;
			downPanAngle = al.camera.panAngle;
			downTiltAngle = al.camera.tiltAngle;
			
			var rp:RaycastPicker=new RaycastPicker(true);
			var target:PickingCollisionVO=rp.getViewCollision(stage.mouseX,stage.mouseY,al.view);
			if(target!=null){
				Mesh(target.entity).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
			
			return true;
		}
		
		public function mouseMove(x:int,y:int):void{
			mouseX=x;
			mouseY=y;
		}
		
		public function mouseUp(x:int,y:int):void{
			//						trace("drag end",x,y,this);
			dragging=false;
		}
		
		
		public function get active():Boolean{
			return currentSize>0;
		}
		
		public function boot(rd:RoomWithDoors,x:int,y:int):void{
			mc5Scene=rd.room.mc5;
			lookAt(x,y);
			//			currentLayer.lookAt(x,y);
			for each(var d:Door in rd.doorList){
				showDoor(d);
			}
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
			Toast.show("加载中...");
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
			for each(var a:Arrow in arrowList){
				a.dispose();
			}
			itemLayer.dispose();
			clearSky();
			bgLayer.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function get x():int{
			return tilt;
		}
		
		public function get y():int{
			return pan;
		}
		
		public function lookAt(x:int,y:int):void{
			al.camera.tiltAngle=x;
			al.camera.panAngle=y;
		}
		
		public function get onDoorClick():Signal
		{
			return _onDoorClick;
		}
		
		public function showDoor(door:Door):void{
			var ac:ArrowClicker=new ArrowClicker(stage,door);
			ac.onMeshReady.addOnce(onMeshReady);
			ac.mc5=door.mc5;
			ac.onDoorClick=onDoorClick;
			arrowList.push(ac);
		}
		
		private function onMeshReady(item:Arrow):void{
			itemLayer.addChild(item.mesh);
		}
	}
}