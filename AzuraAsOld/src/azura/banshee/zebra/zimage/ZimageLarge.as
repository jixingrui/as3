package azura.banshee.zebra.zimage
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.GsI;
	
	public class ZimageLarge extends PyramidFi implements GsI
	{
		
		override public function createTile(fi:int):TileFi{
			return new ZimageLargeTile(fi,this);
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			zMax=zb.readZint();
			for each(var fi:int in super.getPyramidIterator()){
				var tile:ZimageLargeTile=super.getTile_(fi) as ZimageLargeTile;
				tile.fromBytes(zb.readBytesZ());
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(zMax);
			for each(var fi:int in super.getPyramidIterator()){
				var tile:ZimageLargeTile=super.getTile_(fi) as ZimageLargeTile;
				zb.writeBytesZ(tile.toBytes());
			}
			return zb;
		}
		
		public function clear():void{
			
		}
		
		public function getMe5List():Vector.<String>
		{
			var result:Vector.<String>=new Vector.<String>();
			for each(var fi:int in super.getPyramidIterator()){
				var tile:ZimageLargeTile=super.getTile_(fi) as ZimageLargeTile;
				for each(var mc5:String in tile.getMe5List()){
					result.push(mc5);
				}
			}
			return result;
		}
		
	}
}