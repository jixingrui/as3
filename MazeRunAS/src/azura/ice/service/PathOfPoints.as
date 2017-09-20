package azura.ice.service
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	
	public class PathOfPoints implements BytesI
	{
		public var path:Vector.<Point>=new Vector.<Point>();
		
		public function PathOfPoints()
		{
		}
		
		public function toString():String{
			var result:String="";
			for each(var p:Point in path){
				result+="("+p.x+","+p.y+")";
//				sb.append("(").append(p.x).append(",").append(p.y).append(")");
			}
			return result;
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(path.length);
			for each(var p:Point in path){
				zb.writeZint(p.x);
				zb.writeZint(p.y);
			}
			return zb;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var size:int=zb.readZint();
			for(var i:int=0;i<size;i++){
				var p:Point=new Point();
				p.x=zb.readZint();
				p.y=zb.readZint();
				path.push(p);
			}
		}
	}
}