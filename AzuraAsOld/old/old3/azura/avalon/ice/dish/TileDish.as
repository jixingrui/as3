package old.azura.avalon.ice.dish
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.banshee.zebra.zimage.large.TileZimage;
	import old.azura.banshee.naga.Atlas;
	
	import azura.common.collections.ZintBuffer;
	
	public class TileDish extends TileZimage
	{
		public var mc5Cookie:String;
		
		public function TileDish(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
		}
		
//		override public function decode(zb:ZintBuffer):void{
//			super.fromBytes(zb);
//			md5Cookie=zb.readUTF();
//		}
						
//		override public function getKey():String{
//			var p:PyramidDish=pyramid as PyramidDish;
//			var result:String= p.uid+"_"+super.fi;
//			return result;
//		}
	}
}