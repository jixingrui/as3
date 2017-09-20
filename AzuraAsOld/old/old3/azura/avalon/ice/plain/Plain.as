package old.azura.avalon.ice.plain
{
	import old.azura.avalon.base.PyramidBaseOld;
	import old.azura.avalon.ice.MummyOld;
	import azura.common.algorithm.Neck;
	import azura.avalon.ice.multithread.Core1;
	import azura.avalon.ice.multithread.CoreI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	public class Plain
	{
		public var _base:PyramidBaseOld;
		protected var corePath:CoreI=new Core1();		
		public var mummyScreen:MummyOld=new MummyOld();
		
		private var onPathCalculated_:Signal=new Signal();
		/**
		 * 
		 * (path:Vector.&lt;Point&gt;)
		 * 
		 */
		public function get onPathCalculated():Signal{
			return onPathCalculated_;
		}
		
		public function Plain()
		{
		}
		
		public function tick():void{
			mummyScreen.tick();
		}
		
		public function get xFc():int{
			return mummyScreen.currentFc.x;
		}
		
		public function get yFc():int{
			return mummyScreen.currentFc.y;
		}
		
		public function clear():void{
			mummyScreen.clear();
		}
		
		public function walk(xFc:int,yFc:int):void{
			
//			xFc=0;
//			yFc=0;
			
			if(_base==null)
				return;
			
			var isRoadFlat:Boolean=_base.isRoadFlat(xFc/8,yFc/8);
			if(!isRoadFlat)
				return;
			
			var destTp:Point=Neck.fcToTp(xFc,yFc,_base.bound);
			var yOffset:Number=_base.getYOffset(xFc/8,yFc/8);
			
			yOffset=yOffset*_base.scale*Math.SQRT2/8;			
			destTp.y+=yOffset;
			
			var currentTp:Point=mummyScreen.currentTp;
			
			if(!_base.isRoad(currentTp.x,currentTp.y)){
				var tc:Point=Neck.tpToTc(destTp.x,destTp.y,_base.bound);				
				mummyScreen.jump(tc.x,tc.y);
			}else{				
				corePath.find(currentTp.x,currentTp.y,destTp.x,destTp.y);
			}			
		}
		
		public function setBase(zb:ZintBuffer):void{
			_base=new PyramidBaseOld(zb.clone());
			corePath.setBase(zb);
			corePath.pathReady=pathCalculated;
		}
		
		private function pathCalculated(path:Vector.<Point>):void{
			onPathCalculated_.dispatch(path);
		}
		
		public function usePath(path:Vector.<Point>):void{
			mummyScreen.goAlong(path.concat());
		}
		
		public function get scale():Number{
			return _base.scale;
		}
		public function get bound():int{
			return _base.bound;
		}
		
		public function jump(xTc:int,yTc:int):void{
			mummyScreen.jump(xTc,yTc);
		}
	}
}