package old.azura.avalon.ice.dish
{
	import azura.common.collections.BitSet;
	import azura.common.collections.LBSet;
	import azura.common.collections.ZintBuffer;
	
	import flash.display.BitmapData;
	
	public class Shard
	{
		public var x:int,y:int,width:int,height:int,depth:int;
		public var maskData:LBSet;
		
		public function decode(zb:ZintBuffer):void{
			x=zb.readZint();
			y=zb.readZint();
			width=zb.readZint();
			height=zb.readZint();
			depth=zb.readZint();
			maskData=new LBSet(zb.readBytes_());
		}
		
		public function get mask():BitmapData{
			var result:BitmapData=new BitmapData(width,height,true,0x0);
			for each(var pos:int in maskData.getTrueList()){
				result.setPixel32(pos%width,pos/width,0xc0ffffff);
			}
			return result;
		}
	}
}
