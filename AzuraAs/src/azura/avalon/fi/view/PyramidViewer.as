package azura.avalon.fi.view
{
	import azura.avalon.fi.PyramidFi;
	import azura.common.algorithm.FoldIndex;
	
	import flash.geom.Rectangle;
	
	public class PyramidViewer
	{
		private var user:PyramidViewerI;
		
		private var _z:int=-1;		
		private var bsTarget:FiSet= new FiSet();
		private var layer_pyramid:Boolean;
		private var viewLocal:Rectangle;
		
		public function PyramidViewer(user:PyramidViewerI,layer_pyramid:Boolean)
		{
			this.user=user;
			this.layer_pyramid=layer_pyramid;
		}
		public function get z():int
		{
			return _z;
		}
		
		public function set z(value:int):void
		{
			_z = value;
			clear();
			look();
		}
		
		/**
		 * 
		 * @param viewLocal center coordinate, on z
		 * 
		 */
		public function look(viewLocal:Rectangle=null):void {
			
			if(viewLocal!=null)
				this.viewLocal=viewLocal;
			
			if(z<0||this.viewLocal==null)
				return;
			
			if(layer_pyramid)
				lookLayer(this.viewLocal);
			else
				lookPyramid(this.viewLocal);
		}
		
		private function lookLayer(view:Rectangle):void{
			var old:FiSet= bsTarget;
			bsTarget = new FiSet();
			var covers:Vector.<FoldIndex> = FoldIndex.covers(view, z);
			
			var fi:FoldIndex;
			for each (fi in covers) {
				bsTarget.put(fi);
			}
			var deltaPos:FiSet= bsTarget.andNot(old);
			var deltaNeg:FiSet= old.andNot(bsTarget);
			user.pyramidView(bsTarget,deltaPos,deltaNeg);
		}
		
		private function lookPyramid(view:Rectangle):void{
			var old:FiSet= bsTarget;
			bsTarget = new FiSet();
			var covers:Vector.<FoldIndex> = FoldIndex.covers(view, z);
			var fi:FoldIndex;
			for each (fi in covers) {
				bsTarget.put(fi);
				var up:FoldIndex = fi;
				while ((up = FoldIndex.getUp(up)) !=null) {
					bsTarget.put(up);
				}
			}
			var deltaPos:FiSet= bsTarget.andNot(old);
			var deltaNeg:FiSet= old.andNot(bsTarget);
			user.pyramidView(bsTarget,deltaPos,deltaNeg);
		}
		
		public function clear():void{
			user.pyramidView(new FiSet(),new FiSet(),bsTarget);
			bsTarget=new FiSet();
		}
	}
}