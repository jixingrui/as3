package azura.avalon.mouse
{
	import azura.common.algorithm.FastMath;
	
	import flash.events.Event;
	
	public final class MouseManager {		
		private static var instance:MouseManager = new MouseManager();	
		public function MouseManager() {			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" ); 			
		}		
		public static function singleton():MouseManager {			
			return instance;			
		}		
		
		//		private var isDragging:Boolean;
		private var isHolding:Boolean;
		private var dragOverTarget:MouseDragReceiverI;
		
		private var downEvent:MouseEvent=new MouseEvent();
		private var moveEvent:MouseEvent=new MouseEvent();
		private var upEvent:MouseEvent=new MouseEvent();
		
		public function mouseDown(target:MouseTargetI,x:int,y:int):void{
//			trace("mouse down",x,y,target,this);
			
			if(target.active==false)
				return;
			
			if(downEvent.target==null || downEvent.target.priority<target.priority){
				downEvent.target=target;
				downEvent.x=x;
				downEvent.y=y;
				downEvent.processed=false;
			}
			
			moveEvent=new MouseEvent();
			upEvent=new MouseEvent();
		}
		
		public function mouseMove(target:MouseTargetI,x:int,y:int):void{
//			trace("mouse move",x,y,target);
			
			if(target.active==false)
				return;
			
			if(moveEvent.target==null || moveEvent.target.priority<target.priority){
				moveEvent.target=target;
				moveEvent.x=x;
				moveEvent.y=y;
				moveEvent.processed=false;
			}
//			trace("move");			
		}
		
		public function mouseUp(target:MouseTargetI,x:int,y:int):void{
//			trace("mouse up",x,y,target);
			
			if(target.active==false)
				return;
			
			if(upEvent.target==null || upEvent.target.priority<target.priority){
				upEvent.target=target;
				upEvent.x=x;
				upEvent.y=y;
				upEvent.processed=false;
			}
			
			moveEvent.ended=true;
//			moveEvent.target=null;
		}
		
		public function exitFrame(event:Event):void{
//			trace("frame");
			if(downEvent.target!=null && downEvent.processed==false){
				downEvent.processed=true;
				doMouseDown();
			}else if(moveEvent.target!=null && moveEvent.processed==false && moveEvent.ended==false){
				moveEvent.processed=true;
				doMouseMove();
			}else if(upEvent.target!=null && upEvent.processed==false){
				upEvent.processed=true;
				doMouseUp();
			}
		}
		
		private function doMouseDown():void{
			//			trace("doMouseDown");
			//			isDragging=false;
			isHolding=false;
			if(downEvent.target is MouseClickTargetI){
				isHolding=true;
				MouseClickTargetI(downEvent.target).holdOn(downEvent.x,downEvent.y);	
			}
			if(downEvent.target is MouseDragTargetI)
				MouseDragTargetI(downEvent.target).dragStart(downEvent.x,downEvent.y);
		}
		
		private function doMouseMove():void{
			//			trace("doMouseMove");
			if(downEvent.target==null){
				return;
			}else{
				
				if(downEvent.target is MouseClickTargetI && isHolding){
					if(FastMath.dist(downEvent.x,downEvent.y,moveEvent.x,moveEvent.y)>64){
						isHolding=false;
						MouseClickTargetI(downEvent.target).holdOff();
					}
				}
				
				if(downEvent.target is MouseDragTargetI){
					
					MouseDragTargetI(downEvent.target).dragMove(moveEvent.x,moveEvent.y);
					
					if(dragOverTarget!=null && moveEvent.target!=dragOverTarget){
						dragOverTarget.dragOut(moveEvent.x,moveEvent.y,downEvent.target as MouseDragTargetI);
						dragOverTarget=null;
					}
					
					if(moveEvent.target is MouseDragReceiverI){
						dragOverTarget=moveEvent.target as MouseDragReceiverI;
						dragOverTarget.dragIn(moveEvent.x,moveEvent.y,downEvent.target as MouseDragTargetI);
					}
				}
				moveEvent=new MouseEvent();
			}
		}
		
		private function doMouseUp():void{
			if(downEvent.target==null)
				return;
			
			if(isHolding && downEvent.target is MouseClickTargetI)
				MouseClickTargetI(downEvent.target).holdOff();			
			
			if(downEvent.target==upEvent.target && upEvent.target is MouseClickTargetI){
				MouseClickTargetI(upEvent.target).click(upEvent.x,upEvent.y);
			}
			
			if(downEvent.target is MouseDragTargetI)
				MouseDragTargetI(downEvent.target).dragEnd(upEvent.x,upEvent.y);
			
			if(upEvent.target!=downEvent.target && downEvent.target is MouseDragTargetI && upEvent.target is MouseDragReceiverI){
				MouseDragReceiverI(upEvent.target).dragDrop(upEvent.x,upEvent.y,downEvent.target as MouseDragTargetI);
			} 
			
			downEvent=new MouseEvent();
			upEvent=new MouseEvent();
		}
	}
}