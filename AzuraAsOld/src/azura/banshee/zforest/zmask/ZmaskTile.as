package azura.banshee.zforest.zmask
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.banshee.zebra.atlas.Zatlas;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.GsI;
	
	import flash.geom.Point;
	
	public class ZmaskTile extends TileFi implements GsI
	{
		private var _shardPosList:Vector.<Point>;
		private var _atlas:Zatlas;
		private var data:ZintBuffer;
		
		public function ZmaskTile(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
		}
		
		public function get atlas():Zatlas
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
				_atlas=new Zatlas();
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
		
		public function getMe5List():Vector.<String>{
			return atlas.getMe5List();
		}
	}
}