package azura.common.collections.bitset
{
	import flash.utils.ByteArray;
	import azura.common.collections.ObjectCache;
	import azura.common.collections.ZintBuffer;
	

	public class ByteMatrix
	{
		private var size:int;
		private var lbs:LBSet=new LBSet();
		private var map:ByteArray;
		private var oc:ObjectCache;
		
		public function ByteMatrix(size:int,zb:ZintBuffer)
		{
			this.size=size;
			if(zb.readBoolean()){
//				lbs=new LBSet(zb.readBytesZ());
				lbs.fromBytes(zb.readBytesZ());
				oc=new ObjectCache();
			}
			if(zb.readBoolean()){
				map=zb.readBytesZ();
			}
		}
		
		public function hasValue(x:int,y:int):Boolean{
			if(oc==null)
				return false;
			else{
				return getBitSet().getBitAt(x*size+y);
			}
		}
		
		private function getBitSet():BitSet{
			var bs:BitSet=oc.getObj();
			if(bs==null){
				bs=lbs.toBitSet();
				oc.put(bs);				
			}
			return bs;
		}
		
		public function getByte(x:int,y:int):int{
			if(map==null||x>=size||y>=size)
				return 0;
			else{
				var ret:int=map[x*size+y];
				if(ret>127)
					ret-=256;
				return ret;
			}
		}
		
		public function get isEmpty():Boolean{
			return map==null;
		}
	}
}