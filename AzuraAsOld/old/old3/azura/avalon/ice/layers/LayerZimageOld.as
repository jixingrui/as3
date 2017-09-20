package old.azura.avalon.ice.layers
{
	import old.azura.avalon.ice.g2d.RendererG2dOld;
	import old.azura.avalon.ice.g2d.StageG2dOld;
	import azura.avalon.ice.util.DragMoverG2d;
	import old.azura.banshee.zimage.ZimagePlateOld;
	import old.azura.banshee.zimage.plate.ZplateCanvasOld;
	
	import com.genome2d.node.factory.GNodeFactory;
	
	import flash.events.Event;
	import flash.geom.Point;

	public class LayerZimageOld 
	{
		public var zcanvas:ZplateCanvasOld;
		public var bg:ZimagePlateOld;
		
		private var dm:DragMoverG2d=new DragMoverG2d();
		
		private var stageG2d:StageG2dOld;
		
		public function LayerZimageOld(stageG2d:StageG2dOld)
		{
			this.stageG2d=stageG2d;
			stageG2d.onInitialize.addOnce(onInitialize);
			stageG2d.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			function onEnterFrame(e:Event):void{
				dm.tick();
				zcanvas.enterFrame();
			}
			dm.onMove.add(onMove);
		}
		
		protected function onMove(pos:Point):void{
			zcanvas.look(pos.x,pos.y);
		}
		
		protected function onInitialize():void{
			var canvasG2d:RendererG2dOld=GNodeFactory.createNodeWithComponent(RendererG2dOld) as RendererG2dOld;
			stageG2d.nodeGame.addChild(canvasG2d.node);
			zcanvas=new ZplateCanvasOld(canvasG2d);
			
			var bgG2d:RendererG2dOld=GNodeFactory.createNodeWithComponent(RendererG2dOld) as RendererG2dOld;
			bg=new ZimagePlateOld(zcanvas,bgG2d);
			bg.onLoaded.add(onBgLoaded);
			
			stageG2d.nodeGame.onMouseDown.add(dm.onMouseDown);
			stageG2d.nodeGame.onMouseUp.add(dm.onMouseUp);
			stageG2d.nodeGame.onMouseMove.add(dm.onMouseMove);
			
			zcanvas.screenWidth=stageG2d.stage.stageWidth;
			zcanvas.screenHeight=stageG2d.stage.stageHeight;
		}
				
		private function onBgLoaded():void{
			dm.stop();
			dm.setBound(bg.boundingBox,zcanvas.zUp,stageG2d.stage.stageWidth,stageG2d.stage.stageHeight);
		}
		
		public function clear():void{
			dm.jump(0,0);
			if(bg!=null)
				bg.clear();
		}
	}
}