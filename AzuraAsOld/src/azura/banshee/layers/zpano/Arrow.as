package azura.banshee.layers.zpano
{
	import away3d.entities.Mesh;
	
	import azura.banshee.door.GroundItem;
	import azura.common.algorithm.FastMath;
	import azura.common.graphics.Point3;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class Arrow 
	{
		private var _mesh:Mesh;
		
		protected var stage:Stage;
		public var source:GroundItem;
		private var this_:Arrow;
		public var onMeshReady:Signal=new Signal(Arrow);
		
		public function Arrow(stage:Stage,source:GroundItem){
			this.stage=stage;
			this.source=source;
			this_=this;
			source.onUpdate.add(updatePos);
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
			
			new MeshLoader(value).load(meshReady);
			function meshReady(ml:MeshLoader):void{
				
				mesh=ml.mesh.clone() as Mesh;
				mesh.mouseEnabled=true;
				updatePos();
				creationComplete();
				
				onMeshReady.dispatch(this_);
			}
		}
		protected function creationComplete():void{
			//override
			mesh.addEventListener(MouseEvent.CLICK,click);
		}
		
		public function click(event:MouseEvent):void{
		}
		
		public function dispose():void{
			if(mesh==null)
				return;
			
			mesh.removeEventListener(MouseEvent.CLICK,click);
			mesh.dispose();
		}
		
		public function updatePos():void{
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
	}
}