package azura.touch.detector
{
	import azura.common.algorithm.FastMath;
	import azura.touch.gesture.GdragI;
	import azura.touch.gesture.GzoomI;
	import azura.touch.TouchRawI;
	
	public class GDzoom implements TouchRawI
	{
		public var target:GzoomI;
		
		private var newerFinger:GDzoomTouch=new GDzoomTouch();
		private var olderFinger:GDzoomTouch=new GDzoomTouch();
		
		private var lastScaleX:Number=1;
		private var lastScaleY:Number=1;
		
		public function GDzoom(target:GzoomI)
		{
			this.target=target;
		}
		
		public function handDown(handId:int, x:Number, y:Number):void
		{
		}
		
		public function handUp(handId:int, x:Number, y:Number):void
		{
			reset();
		}
		
		public function handMove(handId:int, x:Number, y:Number):void
		{
			if(handId==0)
				return ;
			
//			trace("zoom: handMove",handId,x,y);
			
			if(newerFinger.id==handId){
				//move touch1
				newerFinger.position.x=x;
				newerFinger.position.y=y;
				checkZoom();
			}else if(olderFinger.id==handId){
				//move touch2
				olderFinger.position.x=x;
				olderFinger.position.y=y;
				checkZoom();
			}else{
				//swap
				olderFinger.id=handId;
				olderFinger.start.x=x;
				olderFinger.start.y=y;
				olderFinger.position.x=x;
				olderFinger.position.y=y;
				
				var temp:GDzoomTouch=newerFinger;
				newerFinger=olderFinger;
				olderFinger=temp;
//			}else{
//				//more than 2 touches detected
//				reset();
			}
		}
		
		public function handOut(handId:int):void
		{
			reset();
		}
		
		private function checkZoom():void{
			if(newerFinger.id==0||olderFinger.id==0)
				return;
			
			var oldDistX:Number=FastMath.dist(newerFinger.start.x,0,olderFinger.start.x,0);
			var newDistX:Number=FastMath.dist(newerFinger.position.x,0,olderFinger.position.x,0);
			
			var oldDistY:Number=FastMath.dist(0,newerFinger.start.y,0,olderFinger.start.y);
			var newDistY:Number=FastMath.dist(0,newerFinger.position.y,0,olderFinger.position.y);
			
			var scaleX:Number=(newDistX+100)/(oldDistX+100);
			var scaleY:Number=(newDistY+100)/(oldDistY+100);
			
			target.zoom(scaleX/lastScaleX,scaleY/lastScaleY);
			
			lastScaleX=scaleX;
			lastScaleY=scaleY;
		}
		
		private function reset():void{
			newerFinger.clear();
			olderFinger.clear();
			lastScaleX=1;
			lastScaleY=1;
		}
	}
}