package azura.banshee.zbox3.editor.dish
{
	import azura.common.algorithm.FastMath;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4PackI;
	
	public class Zdishes implements BytesI, Gal4PackI
	{
		private var _angle:int;
		public var dishList:Vector.<Zdish>=new Vector.<Zdish>();
		
		public var yFactor:Number=1;
		
		public function get angle():int
		{
			return _angle;
		}

		public function set angle(value:int):void
		{
			_angle = value;
			yFactor=Math.cos(FastMath.angle2radian(angle));
		}

		public function fromBytes(zb:ZintBuffer):void
		{
			angle=zb.readZint();
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var layer:Zdish=new Zdish(this);
				layer.readFrom(zb);
				dishList.push(layer);
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(angle);
			zb.writeZint(dishList.length);
			for each(var layer:Zdish in dishList){
				layer.writeTo(zb);
			}
			return zb;
		}
		
//		public function clear():void{
//			angle=0;
//			dishList=new Vector.<Zdish>();
//		}
		
		public function getMc5List(dest:Vector.<String>):void{
			for each(var dish:Zdish in dishList){
				dish.getMc5List(dest);
			}
		}
	}
}