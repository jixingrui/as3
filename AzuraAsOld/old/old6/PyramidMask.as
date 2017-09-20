package azura.avalon.fi.mask.old
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.avalon.map.old.AvalonMapUserI;
	
	import azura.common.collections.ZintBuffer;
	
	public class PyramidMask extends PyramidFi
	{
		internal var user:MaskUserI;
		public function PyramidMask(zb:ZintBuffer,user:MaskUserI)
		{
			init(zb.readZint());
			this.user=user;
			for(var layer:int=0;layer<=zMax;layer++){
				for each(var fi:int in super.getLayerIterator(layer)){
					var tile:TileMask=super.getTile_(fi) as TileMask;
					tile.load(zb.readBytes_());
				}
			}
		}
				
		override public function createTile(fi:int):TileFi{
			return new TileMask(fi,this);
		}
		
		public function clear():void{
			
		}
	}
}