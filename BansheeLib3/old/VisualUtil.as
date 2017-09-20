package algorithm
{
	import azura.common.collections.RectC;

	public class VisualUtil
	{
		public static function getEyeMoveRange(screenWidth:int,screenHeight:int,mapBound:RectC):RectC{
			var emr:RectC=mapBound.clone();
			emr.width-=screenWidth;
			emr.height-=screenHeight;
			return emr;
		}
	}
}