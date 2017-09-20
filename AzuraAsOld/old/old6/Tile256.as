package azura.avalon.fi.t256.old
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	
	public class Tile256 extends TileFi
	{
		public function Tile256(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
			this.x*=256;
			this.y*=256;
			this.width*=256;
			this.height*=256;
		}
	}
}