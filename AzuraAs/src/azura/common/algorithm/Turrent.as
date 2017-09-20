package azura.common.algorithm
{
	import flash.geom.Point;
	import azura.common.graphics.Point3;
	
	public class Turrent
	{
		public static function xyz2xy(p3:Point3,degree:int):Point{
			var p2:Point=new Point();
			degree%=360;
			var radian:Number=degree*Math.PI/180;
			p2.x=p3.x*Math.cos(radian)-p3.y*Math.sin(radian);
			p2.y=(p3.x*Math.sin(radian)+p3.y*Math.cos(radian)+p3.z)/Math.SQRT2;
			
			return p2;
		}
		
		public static function xy2xyz(x0:int,y0:int,xn:int,yn:int,degree:int):Point3{
			var p:Point3=new Point3();
			degree%=360;
			if(degree==180){
				p.x=x0;
				p.y=(y0-yn)/Math.SQRT2;
				p.z=(y0+yn)/Math.SQRT2;
			}else{
				var radian:Number=degree*Math.PI/180;
				p.x=x0;
				p.y=(x0*Math.cos(radian)-xn)/Math.sin(radian);
				p.z=y0*Math.SQRT2-p.y;
			}
			return p;
		}
	}
}