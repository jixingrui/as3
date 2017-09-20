package old.azura.avalon.ice
{
	import away3d.core.managers.Stage3DProxy;
	
	import old.azura.avalon.ice.layers.LayerAssG;
	import old.azura.avalon.ice.layers.LayerFloorClearG;
	import old.azura.avalon.ice.layers.LayerFloorMosaicG;
	import old.azura.avalon.ice.layers.LayerFoot;
	import old.azura.avalon.ice.layers.LayerHead;
	import old.azura.avalon.ice.layers.LayerPictureG;
	import old.azura.avalon.ice.map.MapLoaderClearG;
	import old.azura.avalon.ice.map.MapLoaderMiniG;
	import old.azura.avalon.ice.map.MapLoaderMosaicG;
	import old.azura.avalon.ice.plain.PlainCarrier;
	import azura.avalon.ice.loaders.CookieLoader;
	import azura.banshee.loaders.g2d.AtfAtlasLoaderG;
	import azura.banshee.loaders.g2d.FrameLoaderG;
	import old.azura.avalon.ice.swamp.SwampOld;
	import azura.common.algorithm.mover.WalkerI;
	import azura.common.async2.Async2;
	import azura.common.stage3d.Stage3DLayer;
	import azura.common.util.OS;
	
	import com.genome2d.Genome2D;
	import com.genome2d.components.GCameraController;
	import com.genome2d.context.GContextConfig;
	import com.genome2d.node.GNode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.signals.GNodeMouseSignal;
	import com.genome2d.textures.GContextTexture;
	import com.genome2d.textures.GTextureFilteringType;
	
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import org.osflash.signals.Signal;
	
	public class GenomeIceOld extends Stage3DLayer implements WalkerI
	{
		public var g2d:Genome2D;
		public var primePlain:PlainCarrier;
		public var swamp:SwampOld=new SwampOld();
		
		public static var instance:GenomeIceOld;
		
		public var rootGame:GNode;
		public var rootHud:GNode;
		
		private var layerFloorMosaicG:LayerFloorMosaicG;
		private var layerFloorClearG:LayerFloorClearG;
		
		public var layerFoot:LayerFoot;
		
		public var layerAssG:LayerAssG;
		
		public var layerHead:LayerHead;
		
		//		private var layerMini:LayerMapMiniG;
		private var layerPicture:LayerPictureG;
		
		private var config:GContextConfig;
		
		public var cameraGame:GCameraController;
		public var cameraHud:GCameraController;
		
		public var xFc:Number,yFc:Number;
		
		private var onInitialized_:Signal=new Signal();
		
		private var zoomNoWalk:int=0;
		
		private var _walkEnabled:Boolean=true;
		public function get walkEnabled():Boolean
		{
			return _walkEnabled;
		}
		
		public function set walkEnabled(value:Boolean):void
		{
			//			trace(value);
			_walkEnabled = value;
		}
		
		public function showPicture(md5:String):void{
			layerPicture.show(md5);
		}
		
		public function get onInitialized():Signal{
			return onInitialized_;
		}
		
		private var onPathCalculated_:Signal=new Signal();
		/**
		 * 
		 * (path:Vector.&lt;Point&gt;)
		 * 
		 */
		public function get onPathCalculated():Signal{
			return onPathCalculated_;
		}
		
		public function GenomeIceOld(stage:Stage)
		{
			super(stage);
			primePlain=new PlainCarrier();
			primePlain.mummyScreen.mover=this;
			primePlain.onCbReady.add(onCbReady);
			function onCbReady():void{
				
				if(OS.isAndroid){
					var w:Number=stage.stageWidth;
					if(w>=2000){
						zoom=2;
					}else if(w>=1500){
						zoom=1.5;
					}else if(w<1000){
						zoom=0.8;
					}
					trace("width="+w+" zoom="+zoom);
					//					var z:Number=Capabilities.screenDPI/320;
					//					if(z>1){
					//					zoom=z;
					//					}
				}
				
				zoomNoWalk=0;
			}
			primePlain.onPathCalculated.add(onPath);
			function onPath(path:Vector.<Point>):void{
				onPathCalculated_.dispatch(path);
			}
		}
		
		override public function boot(proxy:Stage3DProxy):void
		{
			if(instance!=null)
				return;
			
			instance=this;
			initAsync();
			
			GlobalState.primePlain=primePlain;
			GlobalState.swamp=swamp;
			
			GContextTexture.defaultFilteringType=GTextureFilteringType.NEAREST;
			
			g2d = Genome2D.getInstance();
			g2d.onFailed.add(onFailed);
			g2d.onInitialized.addOnce(onGenome2DInitialized);
			var rect:Rectangle=new Rectangle(0,0,stage.stageWidth, stage.stageHeight);
			config = new GContextConfig(stage,rect);
			
			config.externalStage3D=proxy.stage3D;
			//			GStats.visible=true;
			g2d.init(config);
			g2d.autoUpdateAndRender=false;
			
			function onFailed():void{
				trace("Genome2D failed to initialize");
			}
			
			function onGenome2DInitialized():void {
				
				rootGame=GNodeFactory.createNode();
				g2d.root.addChild(rootGame);
				rootGame.cameraGroup=2;
				
				rootHud=GNodeFactory.createNode();
				g2d.root.addChild(rootHud);
				rootHud.cameraGroup=1;
				
				cameraGame=GNodeFactory.createNodeWithComponent(GCameraController) as GCameraController;
				cameraGame.contextCamera.mask=2;
				g2d.root.addChild(cameraGame.node);
				
				cameraHud=GNodeFactory.createNodeWithComponent(GCameraController) as GCameraController;
				cameraHud.contextCamera.mask=1;
				g2d.root.addChild(cameraHud.node);
				
				g2d.root.addComponent(FpsComp);
				
				//mosaic
				layerFloorMosaicG=GNodeFactory.createNodeWithComponent(LayerFloorMosaicG) as LayerFloorMosaicG;
				primePlain.add(layerFloorMosaicG);
				rootGame.addChild(layerFloorMosaicG.node);
				
				//clear
				layerFloorClearG=GNodeFactory.createNodeWithComponent(LayerFloorClearG) as LayerFloorClearG;
				primePlain.add(layerFloorClearG);
				layerFloorClearG.node.mouseEnabled=true;
				rootGame.addChild(layerFloorClearG.node);
				
				//foot
				layerFoot=GNodeFactory.createNodeWithComponent(LayerFoot) as LayerFoot;
				primePlain.add(layerFoot);
				rootGame.addChild(layerFoot.node);
				
				//ass
				layerAssG=GNodeFactory.createNodeWithComponent(LayerAssG) as LayerAssG;
				primePlain.add(layerAssG);
				rootGame.addChild(layerAssG.node);
				
				
				//head
				layerHead=GNodeFactory.createNodeWithComponent(LayerHead) as LayerHead;
				primePlain.add(layerHead);
				rootGame.addChild(layerHead.node);
				
				//mini
				//				layerMini=GNodeFactory.createNodeWithComponent(LayerMapMiniG) as LayerMapMiniG;
				//				primePlain.add(layerMini);
				//				g2d.root.addChild(layerMini.node);
				
				//picture
				layerPicture=GNodeFactory.createNodeWithComponent(LayerPictureG) as LayerPictureG;
				rootHud.addChild(layerPicture.node);
				GlobalState.layerPictureG=layerPicture;
				
				rootGame.mouseEnabled=true;
				rootGame.onMouseDown.add(onMouseDown);
				rootGame.onMouseUp.add(onMouseUp);
				
				//				trace("ice initialized");
				onInitialized_.dispatch();
			}
		}
		
		public function get zoom():Number{
			return cameraGame.zoom;
		}
		
		public function set zoom(value:Number):void{
			trace("zoom requested");
			if(!walkEnabled)
				return;
			
			value=Math.max(0.5,value);
			value=Math.min(2,value);
			
			var cap:Number=1/Math.sqrt(layerFloorMosaicG.scale);
			
			if(cameraGame.zoom!=value){
				cameraGame.zoom=value;
				primePlain.look(xFc,yFc);
			}
			
			zoomNoWalk=2;
		}
		
		private var onDrag_:Signal=new Signal(Point,Point);
		/**
		 * 
		 * (start:Point,end:Point)
		 * 
		 */
		public function get onDrag():Signal {
			return onDrag_;
		}
		private var dragStart:Point=new Point();
		
		private function onMouseDown(s:GNodeMouseSignal):void{
			//			trace("GenomeIce: mouse down");
			
			var local:Point=new Point(s.localX,s.localY);
			var g:Point = s.dispatcher.transform.localToGlobal(local);
			g.x+=128;
			g.y+=128;
			
			var fc:Point=new Point();
			fc.x=g.x-primePlain.bound*4;
			fc.y=g.y-primePlain.bound*4;
			
			dragStart.x=fc.x;
			dragStart.y=fc.y;
			
			//			zoomNoWalk=false;
		}
		
		private function onMouseUp(s:GNodeMouseSignal):void{
			zoomNoWalk--;
			if(!walkEnabled || zoomNoWalk>0)
				return;
			
			var g:Point = s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
			g.x+=128;
			g.y+=128;
			
			var fc:Point=new Point();
			fc.x=g.x-primePlain.bound*4;
			fc.y=g.y-primePlain.bound*4;
			
			onDrag.dispatch(dragStart,fc);
		}
		
		override public function resize(width:int,height:int):void{
			//			trace("GenomeIce resize: "+width+","+height);
			config.viewRect=new Rectangle(0,0,width,height);
			//			Alert.show("动态改变页面大小会导致点击位置会不准。","已知bug，解决中...");
		}		
		
		override public function enterFrame():void{
			//			trace("GenomeIce: update");
			
			primePlain.tick();
			swamp.tick();	
			
			if(GlobalState.shouldSort()){
				layerAssG.node.sortChildrenOnUserData("depth",false);
			}
			
			//			stage3D.context3D.setCulling(Context3DTriangleFace.NONE);
			g2d.update(0);
			g2d.render();
		}
		
		private function initAsync():void{			
			Async2.newSequence()
				.order(FrameLoaderG,1)
				.order(AtfAtlasLoaderG,1)
				.order(MapLoaderMiniG,1)
				.order(MapLoaderMosaicG,1)
				.order(CookieLoader,1)
				.order(MapLoaderClearG,1);
		}
		public function jumpTo(xFc:int, yFc:int, h:int):void
		{
			//			trace("GC jump to "+xFc+","+yFc);
			
			this.xFc=xFc;
			this.yFc=yFc;
			primePlain.look(xFc,yFc);
			cameraGame.node.transform.x=primePlain.bound*4+xFc-128;
			cameraGame.node.transform.y=primePlain.bound*4+yFc-128;
		}
		
		public function turnTo(angle:int):int
		{
			return 0;
		}
		
		public function go():void
		{
		}
		
		public function stand():void
		{
		}
		
		public function clear():void{
			primePlain.clear();
			layerPicture.clear();
		}
		
		public function walkTo(xFc:int,yFc:int):void{
			//			trace(xFc+","+yFc);
			primePlain.walk(xFc,yFc);
		}
	}
}