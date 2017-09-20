package azura.common.collections.bitset 
{
	
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	public class LBSet implements BytesI{
		private var store:Vector.<int>;
		private var currentValue:Boolean;
		private var writerIndex:int;
		
		public function LBSet() {
			clear();
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			clear();
			var pointer:int=-1;
			while (!zb.isEmpty()) {
				var posTrue:int=pointer+zb.readZint()+1;
				var posFalse:int=posTrue+zb.readZint()+1;
				store.push(posTrue);
				store.push(posFalse);
				pointer=posFalse;
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var prevPos:int = -1;
			var zb:ZintBuffer = new ZintBuffer();
			for each(var value:int in store) {
				zb.writeZint(value - prevPos - 1);
				prevPos = value;
			}
			return zb;
		}
		
		public function clear():void{
			store=new Vector.<int>();
			currentValue=false;
			writerIndex=-1;
		}
		
		public function push(value:Boolean):void {
			writerIndex++;
			if (!value){
			}else if (currentValue) {
				store.splice(store.length-1,1);
				store.push(writerIndex + 1);
			} else {
				store.push(writerIndex);
				store.push(writerIndex + 1);
			}
			currentValue = value;
		}
		
		public function fromBitSet(bs:BitSet):void{
			clear();
			for(var i:int=0;i<bs.length;i++){
				push(bs.getBitAt(i));
			}
		}
		
		public function toBitSet():BitSet{
			var bs:BitSet=new BitSet();
			var from:int = -1;
			var to:int = -1;
			var pos:Boolean = false;
			for each(var i:int in store) {
				if (!pos) {
					from = i;
					pos = true;
				} else {
					to = i;
					bs.setRange(from,to);
					pos = false;
				}
			}
			return bs;
		}
		
		public function getTrueList(): Vector.<int>{
			var que:Vector.<int>=store.concat();
			var result:Vector.<int> = new Vector.<int>()
			var currentPos:int=0;
			var currentGoal:int=0;
			
			while(currentPos!=currentGoal||que.length>0){
				if(currentPos==currentGoal){
					currentPos=que.shift();
					currentGoal=que.shift();
				}
				result.push(currentPos++);
			}
			
			return result;
		}
	}
}
