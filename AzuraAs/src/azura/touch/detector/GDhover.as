package azura.touch.detector
{
	import azura.touch.gesture.GestureI;
	import azura.touch.gesture.GhoverI;
	import azura.touch.gesture.GoutI;
	
	public class GDhover extends Gdetector
	{
		//		public var target:GhoverI;
		
		private var isOver:Boolean;
		
		public function GDhover(user:GestureI)
		{
			//			this.target=target;
			super(user);
		}
		
		public function get hoverTarget():GhoverI{
			return  user as GhoverI;
		}
		
		public function get outTarget():GoutI{
			return user as GoutI;
		}
		
		override public function handDown(touchId:int, x:Number, y:Number):void
		{
			over();
		}
		
		override public function handMove(touchId:int, x:Number, y:Number):void
		{
			//			trace(x,y,this);
			over();
		}
		
		private function over():void{
//						trace("over",this);
			if(!isOver){
				isOver=true;
				if(hoverTarget!=null){
//					trace("dispatch hover",this);
					hoverTarget.hover();
				}
			}
		}
		
		override public function handUp(touchId:int, x:Number, y:Number):void
		{
			if(touchId>0)
				out_();
		}
		
		override public function handOut(touchId:int):void
		{
			out_();
		}
		
		private function out_():void{
//						trace("out",this);
			if(isOver){
				isOver=false;
				if(outTarget!=null)
					outTarget.out();
				//				target.out();
			}
		}
	}
}