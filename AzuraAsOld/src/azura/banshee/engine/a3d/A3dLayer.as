package azura.banshee.engine.a3d
{
	import away3d.containers.View3D;
	import away3d.controllers.FirstPersonController;
	import away3d.core.managers.Stage3DProxy;
	
	import flash.display.DisplayObjectContainer;
	
	public class A3dLayer
	{
		public var view:View3D;		
		public var camera:FirstPersonController;
		
		public function A3dLayer(proxy:Stage3DProxy)
		{
			view = new View3D();
			view.stage3DProxy=proxy;
			view.shareContext=true;
			view.rightClickMenuEnabled=false;
			
			view.camera.lens.far = 14000;
			view.camera.lens.near = 1;
			view.camera.x=0;
			view.camera.y=0;
			view.camera.z=0;
			
			camera = new FirstPersonController(view.camera, 0, 0, -90, 90);
			camera.steps=0;
		}
		
		public function resize(width:int, height:int):void{
			view.width=width;
			view.height=height;
		}
		
		public function enterFrame():void{
			view.render();
		}
	}
}