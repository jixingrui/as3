package old.azura.avalon.ice.dish
{
	import azura.avalon.fi.TileFi;
	import azura.avalon.fi.view.PyramidViewerI;
	import azura.avalon.fi.view.PyramidViewOld;
	import azura.banshee.zebra.zimage.large.PyramidZimage;
	
	import azura.common.collections.ZintBuffer;
	
	public class PyramidDish extends PyramidZimage
	{
		public function PyramidDish()
		{
//			super(null);
		}
						
//		override public function clone():PyramidLand{
//			var result:PyramidDish=new PyramidDish();
//			result.init(this.zMax);
//			result.fi_TileFi=this.fi_TileFi;
//			return result;
//		}
				
		override public function createTile(fi:int):TileFi{
			return new TileDish(fi,this);
		}
	}
}