package azura.common.graphics
{
	import flash.geom.Point;

	public class Bound
	{
		public var landW:int;
		public var landH:int;
		
		public var visualW:int;
		public var visualH:int;
		
		public function Bound()
		{
		}
		
		public function restrict(wish:Point):Point{
			var bw:int=Math.max(0,landW-visualW)/2;
			var bh:int=Math.max(0,landH-visualH)/2;
			
			var result:Point=new Point();
			if(wish.x>bw)
				result.x=bw;
			else if(wish.x<-bw)
				result.x=-bw;
			else
				result.x=wish.x;
			
			if(wish.y>bh)
				result.y=bh;
			else if(wish.y<-bh)
				result.y=-bh;
			else
				result.y=wish.y;
			
			return result;
		}
	}
}