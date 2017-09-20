package azura.banshee.layers
{
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	public class LayerZcombo extends LayerRuler
	{
		private var startPoint:Point=new Point();
		
		public var onPut:Signal=new Signal(int,int,int);
		
		public function LayerZcombo(gl:G2dLayer)
		{
			super(gl);
		}
				
		public function dragStart(x:int, y:int):void
		{	
			startPoint.x=x;
			startPoint.y=y;
		}
		
		public function dragMove(x:int, y:int):void
		{
			onPut.dispatch(x,y,FastMath.xy2Angle(x-startPoint.x,y-startPoint.y));
		}
		
		public function dragEnd(x:int, y:int):void
		{
		}
		
	}
}