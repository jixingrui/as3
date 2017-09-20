package azura.banshee.layers.zpano
{
	import away3d.core.pick.PickingColliderType;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	
	import azura.avalon.mouse.MouseClickTargetI;
	import azura.avalon.mouse.MouseManager;
	import azura.avalon.mouse.MouseTargetI;
	import azura.banshee.door.GroundItem;
	import azura.common.algorithm.FastMath;
	import azura.common.graphics.Point3;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class CopyofArrow 
	{
		private var _mesh:Mesh;
		
		protected var stage:Stage;
		public var source:GroundItem;
//		protected var layer:LayerZpano;
		private var this_:Arrow;
		public var onMeshReady:Signal=new Signal(Arrow);
		
		public function CopyofArrow(stage:Stage,source:GroundItem){
			this.stage=stage;
			this.source=source;
//			this.layer=layer;
			this_=this;
			source.onUpdate.add(updatePos);
						
//			mc5=source.mc5;
		}
		
		public function get mesh():Mesh
		{
			return _mesh;
		}

		public function set mesh(value:Mesh):void
		{
			_mesh = value;
		}

		public function set mc5(value:String):void{
			if(value.length!=42)
				return;
			
//			trace(this,"load mesh",value);
			new MeshLoader(value).load(meshReady);
			function meshReady(ml:MeshLoader):void{
				
//				trace(this_,"mesh",ml.mesh.name);
				
				mesh=ml.mesh.clone() as Mesh;
				mesh.mouseEnabled=true;
//				mesh.PickingColliderType=PickingColliderType.BOUNDS_ONLY;
//				layer.itemLayer.addChild(mesh);
				updatePos();
				creationComplete();
				
				onMeshReady.dispatch(this_);
			}
		}
		protected function creationComplete():void{
			//override
//			mesh.addEventListener(MouseEvent3D.MOUSE_DOWN,onMouseDown);
//			mesh.addEventListener(MouseEvent3D.MOUSE_MOVE,onMouseMove);
//			mesh.addEventListener(MouseEvent3D.MOUSE_UP,onMouseUp);
			mesh.addEventListener(MouseEvent.CLICK,fakeClick);
		}
		
		public function fakeClick(event:MouseEvent):void{
			
		}
		
		public function dispose():void{
//			mesh.removeEventListener(MouseEvent3D.MOUSE_DOWN,onMouseDown);
//			mesh.removeEventListener(MouseEvent3D.MOUSE_MOVE,onMouseMove);
//			mesh.removeEventListener(MouseEvent3D.MOUSE_UP,onMouseUp);
			if(mesh==null)
				return;
			
			mesh.removeEventListener(MouseEvent.CLICK,fakeClick);
			mesh.dispose();
		}
		
//		private function onMouseDown(emd:MouseEvent3D):void{
//			var xCenter:int=stage.mouseX-stage.width/2;
//			var yCenter:int=stage.mouseY-stage.height/2;
//			MouseManager.singleton().mouseDown(this_,xCenter,yCenter);
//		}
//		
//		private function onMouseMove(emm:MouseEvent3D):void{
//			var xCenter:int=stage.mouseX-stage.width/2;
//			var yCenter:int=stage.mouseY-stage.height/2;
//			MouseManager.singleton().mouseMove(this_,xCenter,yCenter);
//		}
//		
//		private function onMouseUp(emu:MouseEvent3D):void{
//			var xCenter:int=stage.mouseX-stage.width/2;
//			var yCenter:int=stage.mouseY-stage.height/2;
//			MouseManager.singleton().mouseUp(this_,xCenter,yCenter);
//		}
		
		protected function updatePos():void{
			if(mesh==null)
				return;
			
			var xyz:Point3=FastMath.tprToxyz(source.x,source.y,800);
			mesh.x=xyz.x;
			mesh.y=xyz.y;
			mesh.z=xyz.z;
			mesh.rotationX=source.tilt;
			mesh.rotationY=source.pan;
			mesh.rotationZ=source.roll;
		}
		
		public function get priority():int
		{
			return 1;
		}
		
		public function get active():Boolean
		{
			return true;
		}
	}
}