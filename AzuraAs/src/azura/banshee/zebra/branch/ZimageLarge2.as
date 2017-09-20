package azura.banshee.zebra.branch
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.banshee.zebra.data.wrap.Zatlas2;
	import azura.common.algorithm.FoldIndex;
	import azura.common.collections.ZintBuffer;
	
	public class ZimageLarge2 extends PyramidFi implements Zebra2BranchI
	{
		public function ZimageLarge2()
		{
		}
		
		private var atlas_:Zatlas2;
		public function set atlas(value:Zatlas2):void{
			this.atlas_=value;
		}
		
		public function get atlas():Zatlas2{
			return atlas_;
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			zMax=reader.readZint();
			for each(var fi:int in getPyramidIterator()){
				var tile:ZimageLarge2Tile=getTile_(fi) as ZimageLarge2Tile;
				tile.readFrom(reader);
			}
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			writer.writeZint(zMax);
			for each(var fi:int in getPyramidIterator()){
				var tile:ZimageLarge2Tile=getTile_(fi) as ZimageLarge2Tile;
				tile.writeTo(writer);
			}
		}
		
		override public function createTile(fi:int):TileFi{
			return new ZimageLarge2Tile(fi,this);
		}
	}
}