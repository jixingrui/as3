package azura.banshee.zbox3
{
	import azura.banshee.zbox3.container.Zbox3ReplicaI;
	import azura.banshee.zbox3.container.Zspace3ControllerEmpty;
	import azura.common.collections.RectC;
	import azura.touch.TouchSpace;
	import azura.touch.TouchStage;
	
	public class Zspace3 extends Zbox3 implements ZcameraI
	{
		internal var touchSpace:TouchSpace=new TouchSpace();
		internal var key:PrivateLock=new PrivateLock();
		
		public function Zspace3(replica:Zbox3ReplicaI)
		{
			super(key, null);
			super.space=this;
			super.replica=replica;
			super.controller=new Zspace3ControllerEmpty();
			
			TouchStage.addLayer(touchSpace);
		}
		
		public function look(x:Number,y:Number,w:Number=0,h:Number=0):void{
			if(width_!=w && w>0)
				width_=w;
			if(height_!=h && h>0)
				height_=h;
			if(width_<=0||width_<=0)
				throw new Error("first look must give a size");
			
			super.move(-x,-y);
//			touchSpace.dx=x;
//			touchSpace.dy=y;
		}
		//================== touch =============
		public function pauseTouch():void{
			touchSpace.pause=true;
		}
		
		public function resumeTouch():void{
			touchSpace.pause=false;
		}
		
		//=================== view =================
		public function get xView():Number{
			return -super.x;
		}
		public function get yView():Number{
			return -super.y;
		}				
		/**
		 * relative to screen, not affected by zoom
		 */
		public function get heightView():Number
		{
			return height_;
		}
		/**
		 * relative to screen, not affected by zoom
		 */
		public function get widthView():Number
		{
			return width_;
		}
		public function get scaleView():Number
		{
			return scaleLocal_;
		}
		public function set scaleView(value:Number):void
		{
			touchSpace.scale=value;
			super.scaleLocal=value;
		}
		//================== override =================
		override public function get xGlobal():Number{
			return 0;
		}
		
		override public function get yGlobal():Number{
			return 0;
		}
		
		override public function get scaleGlobal():Number{
			return 1;
		}
		
		//==================== sealed ==============
		
		override public function get x():Number{
			throw new Error();
		}
		
		override public function get y():Number{
			throw new Error();
		}
		
		override public function set width(value:Number):void{
			throw new Error();
		}
		
		override public function get width():Number{			
			return width_/scaleView;
		}
		
		override public function set height(value:Number):void{
			throw new Error();
		}
		
		override public function get height():Number{
			return height_/scaleView;
		}
		
		override public function set scaleLocal(value:Number):void{
			throw new Error();
		}
		
		override public function get scaleLocal():Number{
			throw new Error();
		}
		
		override public function move(x:Number, y:Number):void{
			throw new Error();
		}
	}
}

/**
 * the rectangle when scale==1 as on ground layer
 */
//		internal function get viewRect():RectC{
//			var vr:RectC=new RectC();
//			vr.width=widthView/scale;
//			vr.height=heightView/scale;
//			vr.xc=xView;
//			vr.yc=yView;
//			return vr;
//		}