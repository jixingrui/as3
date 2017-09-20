package azura.banshee.engine.a3d
{
	
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.SphereGeometry;
	import away3d.textures.Texture2DBase;
	
	/**
	 * ...
	 * @author SeanJD
	 */
	
	public class Scene extends ObjectContainer3D {
		
		private const VIDEO_PATH:String = "./assets/car.mp4";
		
		private var mesh:Mesh;
		private var sphereGeometry:SphereGeometry;
		private var texture2DBase:Texture2DBase;
		private var textureMaterial:TextureMaterial;
		
		public function Scene() {
			super();
			
			sphereGeometry = new SphereGeometry(600, 64, 48);
			texture2DBase = new NativeVideoTexture(VIDEO_PATH, true, true);
			textureMaterial = new TextureMaterial(texture2DBase, true, false, false);
			
			mesh = new Mesh(sphereGeometry, textureMaterial);
			addChild(mesh);
		}
		
	}

}