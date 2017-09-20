package azura.banshee.engine.g2d
{
	import azura.common.algorithm.mover.TimerFps;
	
	import com.genome2d.Genome2D;
	import com.genome2d.components.GCameraController;
	import com.genome2d.context.GContextConfig;
	import com.genome2d.context.stats.GStats;
	import com.genome2d.node.GNode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GContextTexture;
	import com.genome2d.textures.GTextureFilteringType;
	
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.geom.Rectangle;
	
	public final class G2dEngine {		
		private static var instance:G2dEngine = new G2dEngine();	
		public function G2dEngine() {			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" );
		}		

		public function get singleLayer():G2dLayer
		{
			return _singleLayer;
		}

		public static function singleton():G2dEngine {			
			return instance;			
		}	
		
		private var stage:Stage;
		
		private var g2d:Genome2D;		
		private var config:GContextConfig;
		
		private var onInit:Function;
		
		private var layerList:Vector.<G2dLayer>=new Vector.<G2dLayer>();
		
		private var nodeGame:GNode;
		private var camGame:GCameraController;
		
		private var _singleLayer:G2dLayer;
		
		public function init(stage:Stage,stage3D:Stage3D,onInit:Function):void{
			if(g2d!=null)
				throw new Error("G2dEngine: can only init once");
			
			this.stage=stage;
			this.onInit=onInit;
			
			GContextTexture.defaultFilteringType=GTextureFilteringType.NEAREST;
//			GContextTexture.defaultFilteringType=GTextureFilteringType.LINEAR;
			
			g2d = Genome2D.getInstance();
			g2d.onInitialized.addOnce(onGenome2DInitialized);
			var rect:Rectangle=new Rectangle(0,0,stage.stageWidth, stage.stageHeight);
			config = new GContextConfig(stage,rect);			
			config.externalStage3D=stage3D;
			g2d.autoUpdateAndRender=false;
			GStats.visible=true;
			GStats.x=stage.stageWidth-200;
			
			g2d.init(config);
		}
		
		private function onGenome2DInitialized():void {
			
			//cam
			camGame=GNodeFactory.createNodeWithComponent(GCameraController) as GCameraController;
			camGame.contextCamera.mask=1;
			g2d.root.addChild(camGame.node);
			
			//node
			nodeGame=GNodeFactory.createNode();
			nodeGame.cameraGroup=1;
			g2d.root.addChild(nodeGame);
			
			_singleLayer=new G2dLayer();
			_singleLayer.node=nodeGame;
			
			//done
			onInit.call();
		}
		
		public function enterFrame():void{
			g2d.render();
			TimerFps.tick();
		}
		
		public function resize(width:int,height:int):void{
			config.viewRect=new Rectangle(0,0,width,height);
		}
	}
}