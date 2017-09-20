package azura.avalon.fi.land
{
	import azura.avalon.fi.TileFi;
	import azura.avalon.fi.view.PvUserI;
	import azura.avalon.fi.view.PyramidView;
	
	import common.collections.ZintBuffer;
	
	import flash.display.BitmapData;
	
	public class PyramidLand extends PyramidView implements PvUserI
	{
		internal var user:LandUserI;
		
		public function PyramidLand(zb:ZintBuffer,user:LandUserI)
		{
			super(this);
			init(zb.readZint());
			this.user=user;
			for(var layer:int=0;layer<=levelMax;layer++){
				for each(var fi:int in super.getLayerIterator(layer)){
					var tile:TileLand=super.getTile_(fi) as TileLand;
					tile.md5=zb.readUTF();
				}
			}
		}
		
		override public function createTile(fi:int):TileFi{
			return new TileLand(fi,this);
		}
		
		public function seeTile(tile:TileFi):void
		{
			TileLand(tile).observed=true;
		}
		
		public function fogetTile(tile:TileFi):void
		{
			TileLand(tile).observed=false;
			user._removeLand(tile as TileLand);
		}
		
		public function update(tile:TileLand,image:BitmapData):void{			
			user._updateLand(tile,image);			
		}
	}
}