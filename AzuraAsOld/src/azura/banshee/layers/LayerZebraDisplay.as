package azura.banshee.layers
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.mouse.MouseDUMI;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.Neck;
	import azura.touch.watcherOld.WatcherDrag;
	import azura.touch.watcherOld.WatcherEvent;
	
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	import spark.core.SpriteVisualElement;
	
	public class LayerZebraDisplay extends LayerRuler 
	{
		
		public var onTurn:Signal=new Signal(int);
		
		private var wd:WatcherDrag;
		
		public function LayerZebraDisplay(gl:G2dLayer)
		{
			super(gl);
			wd=new WatcherDrag(Statics.stage);
			wd.addEventListener(WatcherEvent.DRAG_END,onDragEnd);
		}
		
		public function onDragEnd(we:WatcherEvent):void{
			var flat:Point=Neck.topToFlat(we.position.x,we.position.y);
			var angle:int=FastMath.xy2Angle(flat.x,flat.y);
			onTurn.dispatch(angle);
		}
		
//		override public function get mouse():MouseDUMI{
//			return null;
//		}
		public function mouseDown(x:int,y:int):Boolean{
			return true;
		}
		
		public function mouseMove(x:int,y:int):void{
		}
		
		public function mouseUp(x:int, y:int):void{
			var flat:Point=Neck.topToFlat(x,y);
			var angle:int=FastMath.xy2Angle(flat.x,flat.y);
			onTurn.dispatch(angle);
		}
	}
}