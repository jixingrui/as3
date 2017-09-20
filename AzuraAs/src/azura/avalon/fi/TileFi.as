package azura.avalon.fi
{
	import azura.common.algorithm.FoldIndex;
	
	import flash.geom.Rectangle;
	
	
	public class TileFi extends Rectangle
	{
		public var fi:FoldIndex;
		public var pyramid:PyramidFi;
		public function TileFi(fi_:int,pyramid:PyramidFi)
		{
			this.fi=FoldIndex.fromFi(fi_);
			this.pyramid=pyramid;
			this.width=1;
			this.height=1;
			this.x=fi.xp;
			this.y=fi.yp;
		}
		public function get layer():int{
			return fi.z;
		}
		public function get upper():TileFi{
			return pyramid.getUpper(fi);
		}
		
//		public function get cx():int{
//			return x-pyramid.bound/2;
//		}
//		
//		public function get cy():int{
//			return y-pyramid.bound/2;
//		}
		
		override public function toString():String{
			return fi.toString();
		}
		
		public function dispose():void{
			
		}
	}
}