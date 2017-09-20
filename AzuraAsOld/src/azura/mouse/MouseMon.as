package azura.mouse
{
	
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class MouseMon
	{
		private static var stage:Stage;
		private static var dumList:Vector.<MouseDUMI>=new Vector.<MouseDUMI>();
		private static var zoomList:Vector.<MouseZoomI>=new Vector.<MouseZoomI>();
		private static var downedMouse:MouseDUMI;
		
		private static var touchOld:TouchHolder=new TouchHolder();
		private static var touchNew:TouchHolder=new TouchHolder();
		
		//		private static var oldDist:Number=0;
		private static var oldDistX:Number=0;
		private static var oldDistY:Number=0;
		
		public static function register(user:MouseI):void{
			if(user is MouseDUMI && dumList.indexOf(user)<0){
				dumList.push(user);
				dumList.sort(sortOnPriority);
			}
			if(user is MouseZoomI&&zoomList.indexOf(user)<0){
				zoomList.push(user);
				zoomList.sort(sortOnPriority);
			}
		}
		
		public static function unregister(user:MouseI):void{
			var idx:int=-1;
			if(user is MouseDUMI){
				idx=dumList.indexOf(user);
				if(idx>=0){
					dumList.splice(idx,1);					
				}
			}
			idx=-1;
			if(user is MouseZoomI){
				idx=zoomList.indexOf(user);
				if(idx>=0){
					zoomList.splice(idx,1);
				}
			}
		}
		
		public static function start(stage_:Stage):void{
			stage=stage_;
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stage.addEventListener(Event.MOUSE_LEAVE,mouseLeave);
			
			//			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			//			stage.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin); 
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd); 
		}
		
		private static function onTouchBegin(event:TouchEvent):void{ 
			trace("touch begin" + event.touchPointID);
			
			//			touchOld=touchNew;
			//			touchNew=new TouchHolder();
			swap();
			touchNew.id=event.touchPointID;
			touchNew.x=stage.mouseX;
			touchNew.y=stage.mouseY;
			
			//			oldDist=FastMath.dist(touchOld.x,touchOld.y,touchNew.x,touchNew.y);
			oldDistX=Math.abs(touchOld.x-touchNew.x);
			oldDistY=Math.abs(touchOld.y-touchNew.y);
			
			trace("oldDistX",oldDistX,"oldDistY",oldDistY);
		} 
		
		private static function swap():void{
			var temp:TouchHolder=touchOld;
			touchOld=touchNew;
			touchNew=temp;
		}
		
		private static function onTouchMove(event:TouchEvent):void{
			//			trace("touch move",event.touchPointID);
			var target:TouchHolder;
			if(touchOld.id==event.touchPointID)
				target=touchOld;
			else if(touchNew.id==event.touchPointID)
				target=touchNew;
			else 
				throw new Error();
			
			
			if(Math.abs(target.x-stage.mouseX)<10&&Math.abs(target.y-stage.mouseY)<10){
//				target.x=stage.mouseX;
//				target.y=stage.mouseY;
				return;
			}
			
			target.x=stage.mouseX;
			target.y=stage.mouseY;
			
			//			var newDist:Number=FastMath.dist(touchOld.x,touchOld.y,touchNew.x,touchNew.y);
			//			var scale:Number=newDist/oldDist;
			//			oldDist=newDist;
			
			var newDistX:Number=Math.abs(touchOld.x-touchNew.x);
			var newDistY:Number=Math.abs(touchOld.y-touchNew.y);
			
//			trace(newDistX,newDistY,oldDistX,oldDistY);
			
			var scaleX:Number=newDistX/oldDistX;
			var scaleY:Number=newDistY/oldDistY;
			oldDistX=newDistX;
			oldDistY=newDistY;
			
			doZoom(scaleX,scaleY);
			//					trace("touch move" + event.touchPointID);
		} 
		
		private static function onTouchEnd(event:TouchEvent):void{ 
			trace("touch end" + event.touchPointID);
			if(touchOld.id==event.touchPointID){
				touchOld.id=0;
			}else if(touchNew.id==event.touchPointID){
				touchNew.id=0;
				swap();
			}else{
				trace("more than 2 touchpoints found");
			}
		}
		
		private static function mouseDown(me:MouseEvent):void{
			
			downedMouse=null;
			
			var x:int=stage.mouseX-stage.stageWidth/2;
			var y:int=stage.mouseY-stage.stageHeight/2;
			
			for(var i:int=0;i<dumList.length;i++){
				var dum:MouseDUMI=dumList[i];
				if(dum.mouseDown(x,y)){
					downedMouse=dum;
					break;
				}
			}
			
			//			if(downedMouse!=null)
			//				trace("down and accepted",i);
		}
		
		private static function mouseMove(me:MouseEvent):void{
			if(downedMouse==null)
				return;
			
			var x:int=stage.mouseX-stage.stageWidth/2;
			var y:int=stage.mouseY-stage.stageHeight/2;
			downedMouse.mouseMove(x,y);
		}
		private static function mouseUp(me:MouseEvent):void{
			if(downedMouse==null)
				return;
			
			var x:int=stage.mouseX-stage.stageWidth/2;
			var y:int=stage.mouseY-stage.stageHeight/2;
			downedMouse.mouseUp(x,y);
			
			downedMouse=null;
		}
		
		private static function mouseLeave(e:Event):void{
			mouseUp(null);
		}
		
		private static function doZoom(scaleX:Number,scaleY:Number):void{
			trace("zoom",scaleX,scaleY);
			for(var i:int=0;i<zoomList.length;i++){
				var zoom:MouseZoomI=zoomList[i];
				if(zoom.zoom(scaleX,scaleY)){
					break;
				}
			}
		}
		
		//		private static function onZoom(e:TransformGestureEvent):void
		//		{
		//			for(var i:int=0;i<zoomList.length;i++){
		//				var zoom:MouseZoomI=zoomList[i];
		//				if(zoom.zoom(e.scaleX,e.scaleY)){
		//					break;
		//				}
		//			}
		//		}
		
		
		private static function sortOnPriority(left:MouseI,right:MouseI):int{
			if(left.priority>right.priority)
				return 1;
			else if(left.priority<right.priority)
				return -1;
			else 
				return 0;
		}
	}
}