package azura.banshee.zebra.branch
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	public class ZimageLarge2Tile extends TileFi implements ZintCodecI
	{
		public var idxInAtlas:int;
		
		public function ZimageLarge2Tile(fi:int,pyramid:PyramidFi)
		{
			super(fi,pyramid);
		}
		
		public function get host():ZimageLarge2{
			return pyramid as ZimageLarge2;
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			idxInAtlas=reader.readZint();
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			writer.writeZint(idxInAtlas);
		}
	}
}