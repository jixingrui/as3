package azura.common.loaders {
	import azura.common.collections.bitset.LBSet;
	import azura.common.collections.ZintBuffer;
	
	import flash.display.BitmapData;
	
	public class Alpha5 {
		private var lbs0:LBSet=new LBSet();
		private var lbs1:LBSet=new LBSet();
		private var lbs2:LBSet=new LBSet();
		private var lbs3:LBSet=new LBSet();	
		private var _isSolid:Boolean;
		
		public function Alpha5(zb:ZintBuffer) {
			zb.uncompress();
			lbs0.fromBytes(zb.readBytesZ());
			lbs1.fromBytes(zb.readBytesZ());
			lbs2.fromBytes(zb.readBytesZ());
			lbs3.fromBytes(zb.readBytesZ());
//			lbs0 = new LBSet(zb.readBytesZ());
//			lbs1 = new LBSet(zb.readBytesZ());
//			lbs2 = new LBSet(zb.readBytesZ());
//			lbs3 = new LBSet(zb.readBytesZ());
			
			_isSolid=lbs0.getTrueList().length==0;
		}
		
		public function get isSolid():Boolean{
			return _isSolid;
		}
		
		public function pasteTo(argb:BitmapData):void {
			var height:int=argb.height;
			var pos:int,i:int,j:int,color:int;
			for each(pos in lbs0.getTrueList()) {
				i= pos / height;
				j= pos % height;
				argb.setPixel32(i, j, 0);
			}
			
			for each(pos in lbs1.getTrueList()) {
				i= pos / height;
				j= pos % height;
				color= argb.getPixel32(i, j);
				argb.setPixel32(i, j, color & 0xffffff| (48<< 24));
			}
			
			for each(pos in lbs2.getTrueList()) {
				i= pos / height;
				j= pos % height;
				color= argb.getPixel32(i, j);
				argb.setPixel32(i, j, color & 0xffffff| (100<< 24));
			}
			
			for each(pos in lbs3.getTrueList()) {
				i= pos / height;
				j= pos % height;
				color= argb.getPixel32(i, j);
				argb.setPixel32(i, j, color & 0xffffff| (150<< 24));
			}
		}
		
	}
}