package azura.avalon.ice.g2d
{
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
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.osflash.signals.Signal;
	
	public final class G2dEngine {		
		private static var instance:G2dEngine = new G2dEngine();	
		public function G2dEngine() {			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" );
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
		
//		private var touchPad:GSprite;
		
//		public var onMouseDown:Signal=new Signal(Number,Number);
//		public var onMouseMove:Signal=new Signal(Number,Number);
//		public var onMouseUp:Signal=new Signal(Number,Number);
		
		public function init(stage:Stage,stage3D:Stage3D,onInit:Function):void{
			if(g2d!=null)
				throw new Error("G2dEngine: can only init once");
			
			this.stage=stage;
			this.onInit=onInit;
			
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

			//cam
			camGame=GNodeFactory.createNodeWithComponent(GCameraController) as GCameraController;
			camGame.contextCamera.mask=1;
			g2d.root.addChild(camGame.node);
			
			//node
			nodeGame=GNodeFactory.createNode();
			nodeGame.cameraGroup=1;
			g2d.root.addChild(nodeGame);
//			nodeGame.mouseEnabled=true;
//			nodeGame.onMouseDown.add(onMouseDown_);
//			nodeGame.onMouseMove.add(onMouseMove_);
//			nodeGame.onMouseUp.add(onMouseUp_);
			
			//touch pad
//			touchPad=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
//			var bd:BitmapData=new BitmapData(stage.stageWidth,stage.stageHeight,false,0x0);
//			touchPad.texture=GTextureFactory.createFromBitmapData("touchPad",bd);
//			touchPad.node.mouseEnabled=true;
//			nodeGame.addChild(touchPad.node);
			
			onInit.call();
		}
		
		public function enterFrame():void{
//			g2d.render(touchPadCam);
			g2d.render();
		}
		
		public function resize(width:int,height:int):void{
			config.viewRect=new Rectangle(0,0,width,height);
		}
		
//		private function onMouseDown_(s:GNodeMouseSignal):void{
//			var p:Point=s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
//			onMouseDown.dispatch(p.x,p.y);
//			trace("G2dEngine: mouse down",p.x,p.y);
//		}
//		
//		private function onMouseMove_(s:GNodeMouseSignal):void{
//			var p:Point=s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
//			onMouseMove.dispatch(p.x,p.y);
//		}
//		
//		private function onMouseUp_(s:GNodeMouseSignal):void{
//			var p:Point=s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
//			onMouseUp.dispatch(p.x,p.y);
//		}
		
//		public function getLayer(idx:int):G2dLayer{
//			while(layerList.length<=idx){
//				layerList.push(null);
//			}
//			
//			var result:G2dLayer=layerList[idx];
//			if(result==null){
//				result=new G2dLayer();
//				result.node=GNodeFactory.createNode();
//				result.node.mouseEnabled=true;
//				nodeGame.addChild(result.node);
//				layerList[idx]=result;
//			}
//			return result;
//		}
//		
//		public function removeLayer(idx:int):void{
//			delete layerList[idx];
//		}
		
//		public function resize(width:int,height:int):void{
//			config.viewRect=new Rectangle(0,0,width,height);
//			
////			GTexture.getTextureById("touchPad").dispose();
////			var bd:BitmapData=new BitmapData(width,height,false,0x0);
////			touchPad.texture=GTextureFactory.createFromBitmapData("touchPad",bd);		
//		}
		
		//		public function enterFrame():void{
		//			for each(var layer:G2dLayer in layerList){
		//				layer.enterFrame();
		//			}
		//		}
	}
}