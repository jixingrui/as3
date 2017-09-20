package pano
{
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.objects.SkyBox;
	
	import azura.gallerid.Gal_Http2;
	
	import common.collections.ZintBuffer;
	import common.stage3d.Stage3DI;
	import common.stage3d.Stage3DLayer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import pano.res.PanoResAtf;
	import pano.res.PanoResJpg;
	
	import spark.components.Alert;
	
	public class PanoView extends Stage3DLayer
	{
		private var rootContainer:Object3D = new Object3D();
		private var camera:Camera3D;
		private var controller:PanoramaCameraController;
		private var sb:SkyBox;
		private var pr:PanoResAtf=new PanoResAtf(panoReady);
		private var holder:Sprite;
		
		public function PanoView(holder:Sprite){
			this.holder=holder;
		}
		
		override protected function initialize():void
		{
			active=false;
			
			camera = new Camera3D(1, 10000);
			camera.view = new View(stage.stageWidth, stage.stageHeight, false, 0xFFFFFF, 0, 0);
			camera.view.hideLogo();
			camera.renderPresentsContext=false;
			camera.rotationX = Math.PI / 2;
			holder.addChild(camera.view);
			rootContainer.addChild(camera);
		}
		
		override public function update():void
		{
			controller.update();
			camera.render(stage3D);
		}
		
		public function load(md5:String):void{
			pr.load(md5);
		}
		
		private function panoReady(sb:SkyBox):void{
			active=true;
			this.sb=sb;
			rootContainer.addChild(sb);
			
			controller=new PanoramaCameraController(camera, stage, stage, stage, false);
			controller.lookAtXYZ(0,0,0);
			controller.mouseSensitivityX=-0.3*24/60;
			controller.mouseSensitivityY=-0.3*24/60;
			
			for each (var resource:Resource in rootContainer.getResources(true)) { 
				resource.upload(stage3D.context3D);
			}
		}
		
		/**
		 *does not interrupt loading 
		 * 
		 */
		public function unload():void{
			if(sb==null)
				return;
			
			sb=null;
			active=false;
			controller.dispose();
		}
	}
}