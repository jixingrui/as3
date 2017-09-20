package azura.avalon.ice.layers
{
	import old.azura.banshee.zimage.ZimagePlateOld;
	import old.azura.banshee.zimage.plate.ZplateCanvasOld;
	import azura.avalon.ice.g2d.old.StageG2dOld;
	import azura.avalon.ice.g2d.old.RendererG2dOld;
	import azura.avalon.ice.util.JumperG2d;
	
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.signals.GNodeMouseSignal;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import azura.banshee.zforest.ZforestPlate;
	
	public class LayerZforestOld extends StageG2dOld
	{
		public var zcanvas:ZplateCanvasOld;
		public var zforest:ZforestPlate;
		public var char:ZimagePlateOld;
		private var jumper:JumperG2d=new JumperG2d();
		
		public function LayerZforestOld(stage:Stage)
		{
			super(stage);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			function onEnterFrame(e:Event):void{
//				zcanvas.enterFrame();
			}
			jumper.onMove.add(onMove);
			function onMove(pos:Point):void{
				char.move(pos.x,pos.y);
				zcanvas.look(pos.x,pos.y);
				moveTouchPad(pos.x,pos.y);
				
				trace(zforest.zbase.canWalk(pos.x,pos.y));
			}
		}
		
		protected function contentInitialize():void{
			var canvasG2d:RendererG2dOld=GNodeFactory.createNodeWithComponent(RendererG2dOld) as RendererG2dOld;
			super.nodeGame.addChild(canvasG2d.node);
			zcanvas=new ZplateCanvasOld(canvasG2d);
			
			zforest=new ZforestPlate(zcanvas,RendererG2dOld.newInstance(),RendererG2dOld.newInstance(),RendererG2dOld.newInstance());
			
			char=new ZimagePlateOld(zforest.zmask,RendererG2dOld.newInstance());
			
			nodeGame.onMouseDown.add(jumper.onMouseDown);
			nodeGame.onMouseMove.add(jumper.onMouseMove);
			nodeGame.onMouseUp.add(jumper.onMouseUp);
			
			zcanvas.screenWidth=stage.stageWidth;
			zcanvas.screenHeight=stage.stageHeight;
		}
		
		public function clear():void{
			
		}
		
		//		private function onMouseDown(s:GNodeMouseSignal):void{
		//			var g:Point=s.dispatcher.transform.localToGlobal(new Point(s.localX,s.localY));
		//			
		//			char.move(g.x,g.y);
		//			zcanvas.look(g.x,g.y);
		//			super.look_(g.x,g.y);
		//		}
	}
}