package azura.touch
{
	import azura.common.collections.RectC;
	import azura.touch.detector.GDdouble;
	import azura.touch.detector.GDdrag;
	import azura.touch.detector.GDhover;
	import azura.touch.detector.GDmove;
	import azura.touch.detector.GDsingle;
	import azura.touch.detector.Gdetector;
	import azura.touch.gesture.GdoubleI;
	import azura.touch.gesture.GdragI;
	import azura.touch.gesture.GestureI;
	import azura.touch.gesture.GhoverI;
	import azura.touch.gesture.GmoveI;
	import azura.touch.gesture.GoutI;
	import azura.touch.gesture.GsingleI;
	
	public class TouchBox implements TouchRawI
	{
		public var space:TouchSpace;
		public var gestureList:Vector.<Gdetector>=new Vector.<Gdetector>();
		public var range:RectC=new RectC();
//		public var priority:Number=0;
		public var user:TouchUserI;
		
		public function TouchBox(user:TouchUserI){
			this.user=user;
		}
		
		public function addUser(user:GestureI):void
		{
			if(user is GmoveI){
				gestureList.push(new GDmove(user as GmoveI));
			}
			if(user is GhoverI){
				gestureList.push(new GDhover(user as GhoverI));
			}
			if(user is GoutI){
				gestureList.push(new GDhover(user as GoutI));
			}
			if(user is GdragI){
				gestureList.push(new GDdrag(user as GdragI));
			}
			if(user is GsingleI){
				gestureList.push(new GDsingle(user as GsingleI));
			}
			if(user is GdoubleI){
				gestureList.push(new GDdouble(user as GdoubleI));
			}
		}
		
		public function removeUser(user:GestureI):void{
			while(removeOneUser(user)){
			}
		}
		
		public function get isEmpty():Boolean{
			return gestureList.length==0;
		}
		
		public function removeAllUser():void{
			gestureList=new Vector.<Gdetector>();
		}
		
		private function removeOneUser(user:GestureI):Boolean{
			for(var i:int=0;i<gestureList.length;i++){
				var detector:Gdetector=gestureList[i];
				if(detector.user==user){
					gestureList.splice(i,1);
					return true;					
				}
			}
			return false;
		}
		
		//==================== up stream ======================
		public function updatePos():void{
			//			trace("update",this);
			if(!enabled)
				return;
			
			space.moveBox(this);
		}
		
		public function dropSelf():void{
			space.dropBox(this);
		}
		
//		public function dispose():void{
//			//			trace("dispose",this);
//			if(space==null)
//				return;
//			space.removeBox(this);
//		}
		
		private var _enabled:Boolean=true;
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			if(_enabled==true && value==false){
				space.removeBox(this);
			}else if(_enabled==false&&value==true){
				space.addBox(this);
			}
			_enabled = value;
		}
		
		public function dispose():void{
			enabled=false;
		}
		
		//=================== down stream ========================			
		public function handDown(handId:int,x:Number,y:Number):void{
			//			trace("test: down",handId,x,y);
			for each(var detector:TouchRawI in gestureList){
				detector.handDown(handId,x,y)
			}
		}
		
		public function handMove(handId:int,x:Number,y:Number):void{
			//			trace("test: move",handId,x,y);
			for each(var detector:TouchRawI in gestureList){
				detector.handMove(handId,x,y)
			}
		}
		
		public function handUp(handId:int,x:Number,y:Number):void{
			//			trace("test: up",handId,x,y);
			for each(var detector:TouchRawI in gestureList){
				detector.handUp(handId,x,y)
			}
		}
		
		public function handOut(handId:int):void{
			//			trace("test: out",handId);
			for each(var detector:TouchRawI in gestureList){
				detector.handOut(handId);
			}
		}
		
		public function drop(apple:TouchBox):void{
			//			if(user_ is GdropI){
			//				return GdropI(user_).drop(apple);
			//			}
//			return false;
		}
	}
}