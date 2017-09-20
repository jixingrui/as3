package old.azura.avalon.ice.g2d
{
	import away3d.core.managers.Stage3DProxy;
	
	import azura.common.stage3d.Stage3DLayer;
	import azura.common.stage3d.old.Stage3DLayerOld;
	
	import com.genome2d.Genome2D;
	import com.genome2d.components.GCameraController;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.context.GContextConfig;
	import com.genome2d.context.stats.GStats;
	import com.genome2d.node.GNode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.signals.GNodeMouseSignal;
	import com.genome2d.textures.GContextTexture;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureFilteringType;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	
	public class StageG2dOld extends Stage3DLayerOld
	{
		private var g2d:Genome2D;		
		private var config:GContextConfig;
		public var nodeHud:GNode;
		public var nodeGame:GNode;
		private var cameraHud:GCameraController;
		private var cameraGame:GCameraController;
		
		private var touchPad:GSprite;
		
		public var onInitialize:Signal=new Signal();
		public var onMouseDown:Signal=new Signal(Number,Number);
		public var onMouseMove:Signal=new Signal(Number,Number);
		public var onMouseUp:Signal=new Signal(Number,Number);
		
//		public function StageG2dOld(stage:Stage,stage3D:Stage3D)
//		{
////			super(stage);
//			boot(stage,stage3D);
//		}
		
//		protected function contentInitialize():void{
//			throw new Error("please override");
//		}
		
		override protected function initialize():void
		{
			GContextTexture.defaultFilteringType=GTextureFilteringType.NEAREST;
			
			g2d = Genome2D.getInstance();
			g2d.onInitialized.addOnce(onGenome2DInitialized);
			var rect:Rectangle=new Rectangle(0,0,stage.stageWidth, stage.stageHeight);
			config = new GContextConfig(stage,rect);			
			config.externalStage3D=stage3D;
			g2d.autoUpdateAndRender=false;
			GStats.visible=true;
			
			g2d.init(config);
		}
		
		private function onGenome2DInitialized():void {
			
			//touch pad
			touchPad=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			var bd:BitmapData=new BitmapData(stage.stageWidth,stage.stageHeight,false,0x0);
			touchPad.texture=GTextureFactory.createFromBitmapData("mousePlate",bd);
			g2d.root.addChild(touchPad.node);
			
			touchPad.node.mouseEnabled=true;
			touchPad.node.onMouseDown.add(onMouseDown_);
			touchPad.node.onMouseMove.add(onMouseMove_);
			touchPad.node.onMouseUp.add(onMouseUp_);
			
			//hud
			nodeHud=GNodeFactory.createNode();
			g2d.root.addChild(nodeHud);
			nodeHud.cameraGroup=1;
			
			cameraHud=GNodeFactory.createNodeWithComponent(GCameraController) as GCameraController;
			cameraHud.contextCamera.mask=1;
			g2d.root.addChild(cameraHud.node);
			
			//game
			nodeGame=GNodeFactory.createNode();
			nodeGame.mouseEnabled=true;
			g2d.root.addChild(nodeGame);
			nodeGame.cameraGroup=2;
			
			cameraGame=GNodeFactory.createNodeWithComponent(GCameraController) as GCameraController;
			cameraGame.contextCamera.mask=2;
			g2d.root.addChild(cameraGame.node);
						
			onInitialize.dispatch();
		}
		
		private function onMouseDown_(s:GNodeMouseSignal):void{
			onMouseDown.dispatch(s.localX,s.localY);
		}
		
		private function onMouseMove_(s:GNodeMouseSignal):void{
			onMouseMove.dispatch(s.localX,s.localY);
		}
		
		private function onMouseUp_(s:GNodeMouseSignal):void{
			onMouseUp.dispatch(s.localX,s.localY);
		}
		
		protected function moveTouchPad(x:int,y:int):void{
//			touchPad.node.transform.x=x;
//			touchPad.node.transform.y=y;
		}
		
		public function resize(width:int,height:int):void{
			config.viewRect=new Rectangle(0,0,width,height);
			GTexture.getTextureById("mousePlate").dispose();
			var bd:BitmapData=new BitmapData(stage.stageWidth,stage.stageHeight,false,0x0);
			touchPad.texture=GTextureFactory.createFromBitmapData("mousePlate",bd);			
		}		
		
		public function enterFrame():void{
			g2d.update(0);
//			g2d.render();
			cameraGame.render();
		}
	}
}