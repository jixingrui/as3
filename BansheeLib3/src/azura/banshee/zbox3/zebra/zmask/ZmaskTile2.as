package azura.banshee.zbox3.zebra.zmask
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.banshee.zebra.data.wrap.Zatlas2;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4PackI;
	
	import flash.geom.Point;
	
	public class ZmaskTile2 extends TileFi implements Gal4PackI
	{
		private var _shardPosList:Vector.<Point>;
		private var _atlas:Zatlas2;
		private var data:ZintBuffer;
		
		public function ZmaskTile2(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
		}
		
		public function get atlas():Zatlas2
		{
			checkLoad();
			return _atlas;
		}
		
		public function get shardPosList():Vector.<Point>
		{
			checkLoad();
			return _shardPosList;
		}
		
		private function checkLoad():void{
			if(_atlas==null){
				_shardPosList=new Vector.<Point>();
				_atlas=new Zatlas2();
				data.position=0;
				_atlas.fromBytes(data.readBytesZ());
				var shardCount:int=data.readZint();
				for(var i:int=0;i<shardCount;i++){
					var p:Point=new Point();
					p.x=data.readZint();
					p.y=data.readZint();
					shardPosList.push(p);
				}
			}
		}
		
		public function fromBytes(zb:ZintBuffer):void{
			this.data=zb;
		}
		
		public function toBytes():ZintBuffer
		{
			data.position=0;
			return data;
		}
		
		public function getMc5List(dest:Vector.<String>):void{
			atlas.getMc5List(dest);
		}
	}
}