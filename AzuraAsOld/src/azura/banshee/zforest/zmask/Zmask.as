package azura.banshee.zforest.zmask
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.GsI;
	
	import flash.geom.Rectangle;
	
	public class Zmask extends PyramidFi implements GsI
	{
		public var boundingBox:Rectangle=new Rectangle();
		
		override public function createTile(fi:int):TileFi{
			return new ZmaskTile(fi,this);
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			boundingBox.x=zb.readZint();
			boundingBox.y=zb.readZint();
			boundingBox.width=zb.readZint();
			boundingBox.height=zb.readZint();
			zMax=zb.readZint();
			for each(var fi:int in super.getPyramidIterator()){
				var tile:ZmaskTile=super.getTile_(fi) as ZmaskTile;
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
				var tile:ZmaskTile=super.getTile_(fi) as ZmaskTile;
				zb.writeBytesZ(tile.toBytes());
			}
			return zb;
		}
		
		public function getMe5List():Vector.<String>{
			var result:Vector.<String>=new Vector.<String>();
			var mc5:String;
			for each(var fi:int in super.getPyramidIterator()){
				var tile:ZmaskTile=super.getTile_(fi) as ZmaskTile;
				for each(mc5 in tile.getMe5List()){
					result.push(mc5);
				}
			}
			return result;
		}
		
		public function clear():void{
			
		}
	}
}