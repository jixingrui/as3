package azura.avalon.zbase.bus
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.bitset.BitSet;
	import azura.common.collections.bitset.LBSet;
	
	import flash.utils.Dictionary;
	
	public class ZbaseTileR extends TileFi implements BytesI
	{
		private var allTrue:Boolean;
		private var allFalse:Boolean;
		private var targetPosData:ZintBuffer;
		private var dupListData:ZintBuffer;
		
		//cache
		private var lbs_:LBSet;
		private var bs:BitSet;
		//		private var dupList:DupList;
		private var idx_Station:Dictionary;
		
		public function ZbaseTileR(fi_:int, pyramid:PyramidFi)
		{
			super(fi_, pyramid);
		}
		
		private function get lbs():LBSet
		{
			if(lbs_==null){
				lbs_=new LBSet();
				lbs_.fromBytes(targetPosData);
			}
			return lbs_;
		}
		
		public function canWalk(x:int,y:int):Boolean{
			if(allTrue)
				return true;
			else if(allFalse)
				return false;
			else{
				if(bs==null)
					bs=lbs.toBitSet();
				return bs.getBitAt(x*pyramid.tileSide+y);
			}
		}
		
		public function getStation(x:int,y:int):int{
			ensureMatrix();
			var idx:int=xyToIdx(x,y);
			return idx_Station[idx];
		}
		
		private function ensureMatrix():void{
			if(idx_Station==null){
				idx_Station=new Dictionary();
				var dupList:DupList=new DupList();
				dupList.fromBytes(dupListData);
				var tl:Vector.<int>=lbs.getTrueList();
				for(var i:int=0;i<tl.length;i++){
					var idx:int=tl[i];
					var station:int=dupList.list[i];
					idx_Station[idx]=station;
//					trace("station",station,this);
					if(station==0)
						trace("station error",this);
				}
			}
		}
		
		private function xyToIdx(x:int, y:int):int{
			return x * pyramid.tileSide + y;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			allTrue=zb.readBoolean();
			allFalse=zb.readBoolean();
			targetPosData=zb.readBytesZ();
			dupListData=zb.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer = new ZintBuffer();
			zb.writeBoolean(allTrue);
			zb.writeBoolean(allFalse);
			zb.writeBytesZ(targetPosData);
			zb.writeBytesZ(dupListData);
			return zb;
		}
		
	}
}