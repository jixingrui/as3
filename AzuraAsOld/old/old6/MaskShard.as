package azura.avalon.fi.mask.old
{
	import azura.common.collections.LBSet;
	import azura.common.collections.ObjectCache;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Image2D;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class MaskShard extends Rectangle
	{
		public var depth:int;
		private var lbsCarve:LBSet;
		private var bdCache:ObjectCache=new ObjectCache();
		
		public function MaskShard(zb:ZintBuffer)
		{
			x=zb.readZint();
			y=zb.readZint();
			width=zb.readZint();
			height=zb.readZint();
			depth=zb.readZint();
			lbsCarve=new LBSet(zb.readBytes_());
		}
		
		public function carve(terrian:BitmapData):BitmapData{
			
			var bd:BitmapData=bdCache.getObj() as BitmapData;
			if(bd==null){
				bd=new BitmapData(this.width,this.height,true,0x0);
				bdCache.put(bd);
				
				for each(var pos:int in lbsCarve.getTrueList()){
					var xPos:int=pos/height;
					var yPos:int=pos%height;				
					var color:int=terrian.getPixel32(x+xPos,y+yPos);
					
					color=setAlpha(color,0.6);
					
					bd.setPixel32(xPos,yPos,color);
				}
			}
			return bd;
		}
		
		private function setAlpha(color:int,alpha:Number):int{
			color&=0x00ffffff;
			var alphaHex:int=256*alpha%256;
			color|=alphaHex<<24;
			return color;
		}
	}
}