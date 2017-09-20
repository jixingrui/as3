package azura.avalon.ice.layers
{
	import azura.banshee.particle.test.StarParticle;
	import azura.banshee.zanime.Zanime;
	import azura.banshee.zimage.Zimage;
	import azura.banshee.zimage.plate.ZplateCanvas;
	import azura.banshee.zmask.Zmask;
	import azura.avalon.ice.util.DragMoverG2d;
	
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.signals.GNodeMouseSignal;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import azura.avalon.ice.g2d.StageG2d;
	import azura.avalon.ice.util.Shine;
	import azura.avalon.ice.g2d.RendererG2d;
	
	public class LayerZimageOld extends StageG2d
	{
		public var zcanvas:ZplateCanvas;
		public var bg:Zimage;
		
		private var dm:DragMoverG2d=new DragMoverG2d();
		
		public function LayerZimageOld(stage:Stage)
		{
			super(stage);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			function onEnterFrame(e:Event):void{
				dm.tick();
				zcanvas.enterFrame();
			}
			dm.onMove.add(onMove);
			function onMove(pos:Point):void{
				zcanvas.look(pos.x,pos.y);
			}
		}
		
		override protected function contentInitialize():void{
			var canvasG2d:RendererG2d=GNodeFactory.createNodeWithComponent(RendererG2d) as RendererG2d;
			super.nodeGame.addChild(canvasG2d.node);
			zcanvas=new ZplateCanvas(canvasG2d);
			
			var bgG2d:RendererG2d=GNodeFactory.createNodeWithComponent(RendererG2d) as RendererG2d;
			bg=new Zimage(bgG2d,zcanvas);
			bg.onLoaded.add(onBgLoaded);
			
			nodeGame.onMouseDown.add(dm.onMouseDown);
			nodeGame.onMouseUp.add(dm.onMouseUp);
			nodeGame.onMouseMove.add(dm.onMouseMove);
		}
		
		override public function resize(width:int, height:int):void{
			zcanvas.screenWidth=stage.stageWidth;
			zcanvas.screenHeight=stage.stageHeight;
		}
		
		private function onBgLoaded():void{
			dm.stop();
			dm.setBound(bg.boundingBox,zcanvas.zUp,stage.stageWidth,stage.stageHeight);
		}
		
		public function clear():void{
			if(bg!=null)
				bg.clear();
		}
		
	}
}