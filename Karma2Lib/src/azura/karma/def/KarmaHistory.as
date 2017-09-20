package azura.karma.def
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.Dictionary;
	
	public class KarmaHistory implements BytesI
	{
		public var versionList:Vector.<KarmaDefV>=new Vector.<KarmaDefV>();
		
		//cache
		private var space:KarmaSpace;
		
		public function KarmaHistory(space:KarmaSpace)
		{
			this.space=space;
		}
		
		public function getHead():KarmaDefV{
			return versionList[0];
		}
		
		public function getVersion(versionField:int):KarmaDefV {
			for each(var v:KarmaDefV in versionList) {
				if (v.version == versionField)
					return v;
			}
			return null;
		}
		
		public function fromBytes(reader:ZintBuffer):void
		{
			var size:int = reader.readZint();
			for (var i:int = 0; i < size; i++) {
				var v:KarmaDefV = new KarmaDefV(space);
				v.readFrom(reader);
				versionList.push(v);
			}
		}
		
		public function toBytes():ZintBuffer
		{
			throw new Error();
		}
	}
}