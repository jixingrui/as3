package azura.avalon.zbase.bus
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	public class DupList implements BytesI
	{
		public var list:Vector.<int>=new Vector.<int>();
		
		public function push(id:int):void {
			list.push(id);
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer = new ZintBuffer();
			var last:int = 0;
			var occor:int = 0;
			for each(var current:int in list) {
				if (occor == 0) {// init
					zb.writeZint(current);
					last = current;
					occor = 1;
				} else if (current == last) {
					occor++;
				} else {
					zb.writeZint(occor);
					zb.writeZint(current);
					last = current;
					occor = 1;
				}
			}
			zb.writeZint(occor);

			zb.compress();
			return zb;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			zb.uncompress();
			if(zb.length<=1)
				return;
			while (zb.isEmpty()==false) {
				var value:int = zb.readZint();
				var occor:int = zb.readZint();
				for (var j:int = 0; j < occor; j++) {
					list.push(value);
				}
			}
		}
	}
}