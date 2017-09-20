package azura.banshee.zbox3
{
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zbox3.container.Zbox3ReplicaI;
	import azura.banshee.zebra.data.wrap.Zframe2I;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.RectC;
	
	import flash.geom.Rectangle;
	
	public class Zbox3Show extends SwapTree3
	{
		public var space:Zspace3;
		
		internal var xParent_:Number=0;
		internal var x_:Number=0;
		internal var yParent_:Number=0;
		internal var y_:Number=0;
		internal var width_:Number=0;
		internal var height_:Number=0;
		
		private var angleParent_:Number=0;
		private var angle_:Number=0;
		
		//customization
		public var replica:Zbox3ReplicaI;
		public var controller:Zbox3ControllerI;
		
		public function Zbox3Show(key:PrivateLock,parent:Zbox3)
		{
			super();
			
			if(key==null)
				throw new Error();
			
			
			if(parent==null){
				if(isRoot==false)
					throw new Error();
				return;
			}
			
			this.parent_=parent;
			this.replica=parent.replica.replicate();
			this.replica.visible=false;
			this.space=parent.space;
			parent.addChild(this);
			
			xParent_=parent.xGlobal;
			yParent_=parent.yGlobal;
			width_=parent.width;
			height_=parent.height;
			angleParent_=parent.angleGlobal;
		}
		
		//======================== x ===================

		
		private var _clip:Boolean;
		
		public function get clip():Boolean
		{
			return _clip;
		}

		public function set clip(value:Boolean):void
		{
			_clip = value;
			notifyChangeSize();
		}

		public function get x():Number
		{
			return x_;
		}
		
		public function set x(value:Number):void
		{
			if(x_==value)
				return;
			
			x_ = value;
			replica.x=value;
			changeXBubbleDown();
		}
		
		internal function changeXBubbleDown():void{
			for each(var child:Zbox3Show in childList){
				child.xParent_=xGlobal;
				child.changeXBubbleDown();
			}
		}
		
		public function get xGlobal():Number{
			return xParent_+x_;
		}
		
		//========================= y ===================

		
		public function get y():Number
		{
			return y_;
		}
		
		public function set y(value:Number):void
		{
			if(y_==value)
				return;
			
			y_ = value;
			replica.y=value;
			changeYBubbleDown();
		}
		
		internal function changeYBubbleDown():void{
			for each(var child:Zbox3Show in childList){
				child.yParent_=yGlobal;
				child.changeYBubbleDown();
			}
		}
		
		public function get yGlobal():Number{
			return yParent_+y_;
		}
		
		//=================== pos ===============
		public function move(x:Number,y:Number):void{

			this.x=x;
			this.y=y;
			
			//			replica.x=x;
			//			replica.y=y;
			
			checkSortMe();
			changeViewBubbleDown();
		}
		
		//========================= width height ==================
	
		public function get height():Number
		{
			return height_;
		}
		
		public function set height(value:Number):void
		{			
			if(value==0){
				trace("Warning: height==0",this);
				return;
			}
			height_ = value;
			notifyChangeSize();
		}		
		
		public function get width():Number
		{
			return width_;
		}
		
		public function set width(value:Number):void
		{
			if(value==0){
				trace("Warning: width==0",this);
				return;
			}
			width_ = value;
			notifyChangeSize();
		}
		
		//================== angle ================

		public function set angle(value:Number):void{
			angle_=angleFit360(value);
			changeAngleBubbleDown();
		}
		public function get angle():Number{
			return angle_;
		}
		
		private function changeAngleBubbleDown():void{
			controller.notifyChangeAngle();
			for each(var child:Zbox3Show in childList){
				child.angleParent_=angleGlobal;
				child.changeAngleBubbleDown();
			}
		}
		
		public function get angleGlobal():Number{
			return angleFit360(angleParent_+angle_);
		}			
		
		private function angleFit360(value:Number):Number{
			while(value<0)
				value+=360;
			while(value>360)
				value-=360;
			return value;
		}
		
		//========================== visible ===============
		public function set alpha(value:Number):void{
			replica.alpha=value;
		}
		
		public function get alpha():Number{
			return replica.alpha;
		}
				
		public function notifyChangeSize():void{
			//			changeViewBubbleDown();
			
			if(!clip)
				return;
			
			var rect:Rectangle=new Rectangle(-width/2,-height/2,width,height);
			rect.left=Math.floor(rect.left);
			rect.right=Math.ceil(rect.right)+1;
			rect.top=Math.floor(rect.top)-1;
			rect.bottom=Math.ceil(rect.bottom);
			//			trace("clip rect",rect.left,rect.right,rect.top,rect.bottom,this);
			replica.clipRect=rect;
		}

		private var visible_:Boolean=true;
		public function set visible(value:Boolean):void{
			visible_=value;
			replica.visible=value;
		}
		
		public function get visible():Boolean{
			return visible_;
		}
		
		//=========================== notify ====================
		override public function notifyLoadingFinish():void{
			if(loader==null)
				return;
			replica.display(loader.resource);
			controller.notifyLoadingFinish();
		}
		override public function notifyInitialized():void{
			replica.visible=visible_;
			//			trace("initialized",controller,this);
			controller.notifyInitialized();
		}
		public function changeViewBubbleDown():void{
			controller.notifyChangeView();
			for each(var child:Zbox3Show in childList){
				child.changeViewBubbleDown();
			}
		}
		
		//========================== override =================
		override public function get isRoot():Boolean{
			return this is Zspace3;
		}
		
		override public function get isDisposed():Boolean{
			return replica==null;
		}
		
		override protected function swapChildren(one:int, two:int):void{
			replica.swapChildren(one,two);
			super.swapChildren(one,two);
		}
		
		override public function removeChild(child:NakedTree):void{
			var c:Zbox3=child as Zbox3;
			replica.removeChild(c.replica);
			super.removeChild(child);
		}
		
		override public function dispose():void{
			super.dispose();
			replica=null;
			controller.notifyDispose();
		}
		
		override public function notifyClear():void{
			controller.notifyClear();
		}
		
		//======================== to override ===============
		public function newChild():Zbox3{
			throw new Error();
		}
		
	}
}