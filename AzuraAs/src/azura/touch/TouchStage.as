package azura.touch
{
	
	import air.update.events.DownloadErrorEvent;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.getTimer;
	
	/**
	 * 
	 * TouchStage accepts one mouse and two touches. The mouse touchId is 0.
	 * 
	 */
	public class TouchStage
	{
		
		public static var DOWN:String="	DOWN";
		public static var MOVE:String="MOVE";
		public static var UP:String="UP";
		public static var OUT:String="	OUT";
		
		public static var fingerRadius:Number;
		
		private static var stage:Stage;
		private static var layerList:Vector.<TouchRawI>=new Vector.<TouchRawI>();
		private static var _screenSpace:TouchSpace=new TouchSpace();
		
		private static var mouseIsDown:Boolean;
		private static var olderFinger:TouchData=new TouchData();
		private static var newerFinger:TouchData=new TouchData();
		private static var lastTouchTime:int;
		
		public static function get screenSpace():TouchSpace
		{
			return _screenSpace;
		}
		
		public static function start(stage_:Stage):void
		{
			if(stage!=null)
				throw new Error("duplicate initialization");
			
			stage=stage_;
			
			fingerRadius=stage.stageWidth/80;
			
			addLayer(screenSpace);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, touchBeginR); 
			stage.addEventListener(TouchEvent.TOUCH_MOVE, touchMoveR); 
			stage.addEventListener(TouchEvent.TOUCH_END, touchEndR); 
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownR);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveR);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpR);
		}
		
		//============================== raw event ======================
		private static function touchBeginR(event:TouchEvent):void{
			lastTouchTime=getTimer();
			trace("Stage: touch down",event.touchPointID,event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
			fingerDown(event.touchPointID,event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
		}
		
		private static function mouseDownR(event:MouseEvent):void{
			if(getTimer()-lastTouchTime<500)
				return;
			//						trace("mouse down",0,event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
			mouseDown(event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
		}
		
		private static function touchMoveR(event:TouchEvent):void{
			lastTouchTime=getTimer();
			//						trace("Stage: touch move",event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
			fingerMove(event.touchPointID,event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
		}
		
		private static function mouseMoveR(event:MouseEvent):void{
			if(getTimer()-lastTouchTime<500)
				return;
			//			trace("mouse move",event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
			mouseMove(event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
		}
		
		private static function touchEndR(event:TouchEvent):void{
			lastTouchTime=getTimer();
			trace("Stage: touch up",event.touchPointID,event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
			fingerUp(event.touchPointID,event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
		}
		
		private static function mouseUpR(event:MouseEvent):void{
			if(getTimer()-lastTouchTime<500)
				return;
			//			trace("TouchStage: mouse up");
			mouseUp(event.stageX-stage.stageWidth/2,event.stageY-stage.stageHeight/2);
		}		
		
		//==================== center coordinate =========================
		private static function mouseDown(x:Number,y:Number):void{
			if(mouseIsDown)
				return;
			else
				mouseIsDown=true;			
			
			for each(var layer:TouchRawI in layerList){
				if(layer.handDown(0,x,y)){
					break;
				}
			}
		}
		
		private static function fingerDown(id:int,x:Number,y:Number):void{
			
			//filter
			if(id==newerFinger.id||id==olderFinger.id)
				return;
			
			if(olderFinger.id>0){
				for each(var layer:TouchRawI in layerList){
					if(layer.handUp(olderFinger.id,x,y)){
						break;
					}
				}
			}
			
			olderFinger.id=id;
			olderFinger.x=x;
			olderFinger.y=y;
			var hold:TouchData=newerFinger;
			newerFinger=olderFinger;
			olderFinger=hold;
			
			//			trace("hand down",id,x,y);
			
			for each(var layer2:TouchRawI in layerList){
				if(layer2.handDown(id,x,y)){
					break;
				}
			}
		}
		
		private static function fingerMove(id:int,x:Number,y:Number):void{
			
			if(id==newerFinger.id){
				if(x==newerFinger.x&&y==newerFinger.y)
					return;
				
				newerFinger.x=x;
				newerFinger.y=y;
			}else if(id==olderFinger.id){
				if(x==olderFinger.x&&y==olderFinger.y)
					return;
				
				olderFinger.x=x;
				olderFinger.y=y;
			}else{
				for each(var layer:TouchRawI in layerList){
					if(layer.handUp(id,x,y)){
						break;
					}
				}
				fingerDown(id,x,y);
			}
			
			for each(var layer2:TouchRawI in layerList){
				if(layer2.handMove(id,x,y)){
					break;
				}
			}
		}
		
		private static function mouseMove(x:Number,y:Number):void{
			//			trace("move by TouchZ");
			for each(var layer:TouchRawI in layerList){
				if(layer.handMove(0,x,y)){
					break;
				}
			}
		}
		
		private static function fingerUp(id:int,x:Number,y:Number):void{
			
			if(id!=olderFinger.id&&id!=newerFinger.id)
				return;
			
			if(id==olderFinger.id){
				olderFinger.clear();
			}else if(id==newerFinger.id){
				newerFinger=olderFinger;
				olderFinger=new TouchData();
			}
			
			for each(var layer:TouchRawI in layerList){
				if(layer.handUp(id,x,y)){
					break;
				}
			}
		}
		
		private static function mouseUp(x:Number,y:Number):void{
			
			//filter
			if(!mouseIsDown){
				return;
			}
			
			mouseIsDown=false;
			
			for each(var layer:TouchRawI in layerList){
				if(layer.handUp(0,x,y)){
					break;
				}
			}
		}
		//======================= support ===================
		
		private static function reset(x:Number,y:Number):void{
			mouseIsDown=false;
			if(olderFinger.id>0){
				for each(var layer:TouchRawI in layerList){
					if(layer.handUp(olderFinger.id,x,y)){
						break;
					}
				}
			}
			
			if(newerFinger.id>0){
				for each(var layer2:TouchRawI in layerList){
					if(layer2.handUp(newerFinger.id,x,y)){
						break;
					}
				}
			}
			olderFinger.clear();
			newerFinger.clear();
		}
		
		public static function addLayer(layer:TouchRawI):void{
			if(layer==null)
				throw new Error();
			layerList.push(layer);
		}
		
		public static function removeLayer(layer:TouchRawI):void{
			var idx:int=layerList.indexOf(layer);
			layerList.splice(idx,1);
		}
		
		public static function set screenLayerActive(active:Boolean):void{
			var idx:int=layerList.indexOf(screenSpace);
			if(active&&idx==-1){
				addLayer(screenSpace);
			}else if(!active&&idx!=-1){
				layerList.splice(idx,1);
			}
		}
		
	}
}