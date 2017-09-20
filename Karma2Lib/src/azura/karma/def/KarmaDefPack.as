package azura.karma.def
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.karma.editor.def.KarmaDef;
	
	public class KarmaDefPack implements BytesI
	{
		public var core:KarmaDef=new KarmaDef();
		
		public function KarmaDefPack()
		{
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			core.fromBytes(zb.readBytesZ());
		}
		
		public function toBytes():ZintBuffer
		{
			throw new Error();
		}
	}
}