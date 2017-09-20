package azura.banshee.zbox2
{
	import azura.banshee.zbox2.engine.Zbox2ReplicaI;
	import azura.banshee.zebra.data.wrap.Zframe2I;
	import azura.banshee.zebra.data.wrap.Zframe2ListenerI;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.RectC;
	import azura.touch.TouchBox;
	import azura.touch.gesture.GestureI;
	
	import flash.geom.Rectangle;
	
	public class Zbox2 extends SwapTree implements Zframe2ListenerI
	{
		public var space:Zspace2;
		
		//customization
		public var replica:Zbox2ReplicaI;
		public var controller:Zbox2ControllerI;
		
		//display
		private var frameCurrent:Zframe2I;
		private var frameFuture:Zframe2I;
		
		//state
		public var loadingZup:int;
		private var displayingZup:int;
		
		//properties
		private var x_:Number=0;
		private var y_:Number=0;
		private var width_:Number=0;
		private var height_:Number=0;
		
		//touch: to match touch with visual, use pivot
		private var touchBox_:TouchBox;
		public var pivotX:Number=0;
		public var pivotY:Number=0;
		
		private var scaleParent_:Number=1;
		private var scaleLocal_:Number=1;
		
		private var angleParent_:Number=0;
		private var angleLocal_:Number=0;
		
		public var clip:Boolean;
		
		public function Zbox2(key:PrivateLock,parent:Zbox2,delayedSwapper:Boolean)
		{
			super(delayedSwapper);
			
			if(key==null)
				throw new Error();
			
			if(parent==null){
				if(!(this is Zspace2))
					throw new Error();
				return;
			}
			
			this.replica=parent.replica.replicate();
			this.space=parent.space;
			parent.addChild(this);
			
//			if(isState)
//				this.replica.visible=false;
		}
		
		//======================= tructure ===============

		public function get y():Number
		{
			return y_;
		}

		public function set y(value:Number):void
		{
			y_ = value;
		}

		public function get x():Number
		{
			return x_;
		}

		public function set x(value:Number):void
		{
			x_ = value;
		}

		public function get height():Number
		{
			return height_;
		}

		public function set height(value:Number):void
		{
			height_ = value;
			checkClip();
		}

		public function get width():Number
		{
			return width_;
		}

		public function set width(value:Number):void
		{
			width_ = value;
			checkClip();
		}
		
		public function checkClip():void{
			if(!clip)
				return;
			
			var rect:Rectangle=new Rectangle(-width/2,-height/2,width,height);
//			trace("clip rect",rect.left,rect.right,rect.top,rect.bottom,this);
			replica.clipRect=rect;
		}

		public function newChild(isState:Boolean):Zbox2{
			return new Zbox2(space.key,this,isState);
		}
		
		public function addChild(child:Zbox2):void{
			addChild_(child);
		}
		
		override protected function addChild_(c:SwapTree):void{
			super.addChild_(c);
			var child:Zbox2=c as Zbox2;
			this.replica.addChild(child.replica);
			
			child.scaleParent_=this.scaleGlobal;
			child.angleParent_=this.angleGlobal;
		}
		
		public function removeChild(child:Zbox2):void{
			removeChild_(child);
		}
		
		override protected function removeChild_(child:SwapTree):void{
			super.removeChild_(child);
			replica.removeChild(Zbox2(child).replica);
		}
		
		override protected function swapChildren(one:int,two:int):void{
			super.swapChildren(one,two);
			replica.swapChildren(one,two);
		}
		
		override public function clear():void{
			replica.unDisplay();
			unload();
			controller.notifyClear();
			super.clear();
		}
		
		override public function dispose():void{
			super.dispose();
			if(touchBox_!=null){
				touchBox_.dispose();
				touchBox_=null;
			}
			controller.notifyDispose();
			controller=null;
		}
		
		//=================== pos ===============
		public function move(x:Number,y:Number):void{
			x_=x;
			y_=y;
			
//			x=Math.floor(x);
//			y=Math.floor(y);
			
			replica.x=x;
			replica.y=y;

			if(!isRoot && parent.keepSorted){
				parent.sortOne(this);
			}
			moveBubbleDown();
		}
		
		public function moveBubbleDown():void{
			controller.notifyChangeView();
			updateTouch();
			for each(var child:Zbox2 in childList){
				child.moveBubbleDown();
			}
		}
		
		public function updateTouch():void{
			if(touchBox_!=null){
//				touchBox_.box=boxGlobal;
				touchBox_.updatePos();
			}
		}
		
		public function get xGlobal():Number{
			var xg:Number=0;
			var pointer:Zbox2=this;
			while(pointer!=null && !pointer.isRoot){
				xg+=pointer.x;
				pointer=pointer.parent as Zbox2;
			}
			return xg;
		}
		
		public function get yGlobal():Number{
			var yg:Number=0;
			var pointer:Zbox2=this;
			while(pointer!=null && !pointer.isRoot){
				yg+=pointer.y;
				pointer=pointer.parent as Zbox2;
			}
			return yg;
		}
		
		//======================= display =================		
		/**
		 *  starts loading immediatly. cancels previous loading or loaded
		 */
		public function load(frame:Zframe2I,zUp:int):void{	
			
			if(frame==null)
				throw new Error();
			
			if(frame==frameCurrent){
				throw new Error("duplicate frame feed");
			}
			
			super.notifyLocalLoadingStart();
			
			this.loadingZup=zUp;
			
			if(frameFuture!=null){
				frameFuture.endUse(this);
				frameFuture=null;
			}
			
			frameFuture=frame;
			//====================== broken ==================
//			frameFuture.startUse(this,replica);
		}
		
		public function unload():void{
			idle_loading_loaded=0;
			if(frameCurrent!=null){
				frameCurrent.endUse(this);
				frameCurrent=null;
			}
			if(frameFuture!=null){
				frameFuture.endUse(this);
				frameFuture=null;
			}
		}
		
		public function notifyZframe2Loaded():void{
			display();
			notifyLocalLoadingFinish();
			controller.notifyLoadingFinish();
		}
		
		internal function display():void{
			
			displayingZup=loadingZup;
			
			if(frameFuture!=null){
				if(frameCurrent!=null){
					replica.unDisplay();
					//					trace("unloading current",frameCurrent.idxInAtlas,this);
					frameCurrent.endUse(this);
					frameCurrent=null;
				}
				
				//				trace("using future",frameFuture.idxInAtlas,this);
				frameCurrent=frameFuture;
				frameFuture=null;
				replica.display(frameCurrent);
				pivotX=frameCurrent.dx;
				pivotY=frameCurrent.dy;
				updateTouch();
				//				trace("displaying",frameCurrent.idxInAtlas,this);
				updateScaleUnderZup();
			}
		}
				
		//====================== support ==================
		
		public function set alpha(value:Number):void{
			replica.alpha=value;
		}
		
		public function set visible(value:Boolean):void{
			replica.visible=value;
			if(touchBox_!=null){
				touchBox_.enabled=value;
			}
		}
		
		public function get visible():Boolean{
			return replica.visible;
		}
		
		public function get screenOnBox():RectC{
			var local:RectC=space.viewRect;
			local.xc-=this.xGlobal;
			local.yc-=this.yGlobal;
			return local;
		}
		
		public function get boxGlobal():RectC{
			var rc:RectC=new RectC();
			rc.width=width;
			rc.height=height;
			rc.xc=xGlobal+pivotX;
			rc.yc=yGlobal+pivotY;
			return rc;
		}
		
		override protected function swapOn():void{
			visible=true;
		}
		
		override public function get sortValue():Number{
			return controller.sortValue;
		}
		
		//====================== scale =================		
		public function set scaleLocal(value:Number):void{
			scaleLocal_=value;
			replica.scaleX=value;
			replica.scaleY=value;
			scaleChangeBubbleDown();
		}
		
		public function get scaleLocal():Number{
			return scaleLocal_;
		}
		
		public function get scaleGlobal():Number{
			return scaleParent_*scaleLocal_;
		}
		
		private function scaleChangeBubbleDown():void{
			controller.notifyChangeScale();
			updateScaleUnderZup();
			for each(var child:Zbox2 in childList){
				child.scaleParent_=scaleGlobal;
				child.scaleChangeBubbleDown();
			}
		}
		
		public function updateScaleUnderZup():void{
			var renderScale:Number=scaleLocal*FastMath.pow2x(displayingZup);
			//			trace("render scale",renderScale,this);
			replica.scaleX=renderScale;
			replica.scaleY=renderScale;
		}
		
		public function get zUpGlobal():int{
			return FastMath.log2(Math.floor(1/(scaleGlobal)));
		}
		
		//================== angle ================
		public function set angleLocal(value:Number):void{
			angleLocal_=angleFit360(value);
			angleUpdated();
		}
		
		private function angleUpdated():void{
			controller.notifyChangeAngle();
			for each(var child:Zbox2 in childList){
				child.angleParent_=angleGlobal;
				child.angleUpdated();
			}
		}
		
		public function get angleGlobal():Number{
			return angleFit360(angleParent_+angleLocal_);
		}			
		
		private function angleFit360(value:Number):Number{
			while(value<0)
				value+=360;
			while(value>360)
				value-=360;
			return value;
		}
		
		//=============== touch =================
		private function get touchBox():TouchBox
		{
			if(touchBox_==null){
//				touchBox_=new TouchBox();
//				touchBox_.box=boxGlobal;
//				space.touchSpace.putBox(touchBox_);
			}
			return touchBox_;
		}
		
		public function addGesture(user:GestureI):void{
			touchBox.addUser(user);
		}
		
		public function removeGesture(user:GestureI):void{
			touchBox.removeUser(user);
			if(touchBox_.isEmpty){
				space.touchSpace.removeBox(touchBox_);
			}
		}
		
		public function removeGestureAll():void{
			touchBox.removeAllUser();
		}
	}
}