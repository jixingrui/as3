package azura.banshee.zbox3.zebra.zmask
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4PackI;
	
	import flash.geom.Rectangle;
	
	public class Zmask2 extends PyramidFi implements Gal4PackI,BytesI
	{
		public var boundingBox:Rectangle=new Rectangle();
		
		override public function createTile(fi:int):TileFi{
			return new ZmaskTile2(fi,this);
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			boundingBox.x=zb.readZint();
			boundingBox.y=zb.readZint();
			boundingBox.width=zb.readZint();
			boundingBox.height=zb.readZint();
			zMax=zb.readZint();
			for each(var fi:int in super.getPyramidIterator()){
				var tile:ZmaskTile2=super.getTile_(fi) as ZmaskTile2;
				tile.fromBytes(zb.readBytesZ());
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(boundingBox.x);
			zb.writeZint(boundingBox.y);
			zb.writeZint(boundingBox.width);
			zb.writeZint(boundingBox.height);
			zb.writeZint(zMax);
			for each(var fi:int in super.getPyramidIterator()){
				var tile:ZmaskTile2=super.getTile_(fi) as ZmaskTile2;
				zb.writeBytesZ(tile.toBytes());
			}
			return zb;
		}
		
		public function getMc5List(dest:Vector.<String>):void{
			var mc5:String;
			for each(var fi:int in super.getPyramidIterator()){
				var tile:ZmaskTile2=super.getTile_(fi) as ZmaskTile2;
				tile.getMc5List(dest);
			}
		}
		
	}
}