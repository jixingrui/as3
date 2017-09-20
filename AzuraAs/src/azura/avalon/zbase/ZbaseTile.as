package azura.avalon.zbase
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.common.collections.bitset.BitSet;
	import azura.common.collections.BytesI;
	import azura.common.collections.bitset.LBSet;
	import azura.common.collections.ZintBuffer;
	
	public class ZbaseTile extends TileFi implements BytesI
	{
		private var allTrue:Boolean;
		private var allFalse:Boolean;
		private var lbsData:ZintBuffer;
		private var lbs_:LBSet;
		private var bs:BitSet;
		
		public function ZbaseTile(fi_:int, pyramid:PyramidFi)
		{
			super(fi_, pyramid);
		}
		
		private function get lbs():LBSet
		{
			if(lbs_==null){
				lbs_=new LBSet();
				lbs_.fromBytes(lbsData);
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
		
		public function fromBytes(zb:ZintBuffer):void
		{
			allTrue=zb.readBoolean();
			allFalse=zb.readBoolean();
			lbsData=zb.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBoolean(allTrue);
			zb.writeBoolean(allFalse);
			zb.writeBytesZ(lbsData);
			return zb;
		}
		
	}
}