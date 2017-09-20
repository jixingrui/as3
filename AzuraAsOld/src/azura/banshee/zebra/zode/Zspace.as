package azura.banshee.zebra.zode
{
	import azura.banshee.zebra.box.AbBoxRoot;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.zode.i.ZRnodeI;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.aabb.AABBTree;
	import azura.common.collections.BoxC;
	import azura.touch.TouchSpace;
	import azura.touch.TouchRawI;
	import azura.touch.TouchStage;
	import azura.touch.gesture.GestureI;
	
	import flash.geom.Rectangle;
	
	public class Zspace implements TouchRawI
	{
		internal var touchLayer:TouchSpace=new TouchSpace();
		public var root:ZboxOld=new ZboxOld();
		private var box:BoxC=new BoxC();
		
		public final function Zspace(renderer:ZRnodeI,screenWidth:int,screenHeight:int)
		{
			root.renderer=renderer;
			root.space=this;
			
			box.bb.width=screenWidth;
			box.bb.height=screenHeight;
//			box.lbb.x=-screenWidth/2;
//			box.lbb.y=-screenHeight/2;
		}
		
		public function get viewGlobal():Rectangle
		{
			var rect:Rectangle=new Rectangle();
			rect.width=box.bb.width/root.scaleLocal;
			rect.height=box.bb.height/root.scaleLocal;
			rect.x=box.pos.x+box.bb.left;
			rect.y=box.pos.y+box.bb.top;
			return rect;
		}
		
//		override public function set user(value:GestureI):void{
//			throw new Error("ZboxRoot cannot touch");
//		}
//		
//		override public function move(x:Number, y:Number):void{
//			throw new Error("cannot move root");
//		}
		
		public function set scaleLocal(value:Number):void{
			if(Math.abs(value)<0.1)
				return;
			
			root.scaleLocal=value;
//			super.scaleLocal=value;
			root.move(-box.pos.x*value,-box.pos.y*value);	
			root.updateVisual();
		}
		
		
		public function clear():void{
			
		}
		
		public function dispose():void{
			
		}
		
		public function enterFrame():void{
			root.enterFrame();
		}
		public function get scaleLocal():Number{
			return root.scaleLocal;
		}
		
		/**
		 * 
		 * @param xy Let the initial center point as origion axis. Focus on the target Point(x,y)
		 * @param box the visual box on the origion.
		 * 
		 */
		public function lookAt(x:Number,y:Number):void{
			trace("visual at",x,y,this);
			box.pos.x=x;
			box.pos.y=y;
			root.move(-box.pos.x*root.scaleLocal,-box.pos.y*root.scaleLocal);
			root.updateVisual();
		}
		
		public function get xView():Number{
			return box.pos.x;
		}
		
		public function get yView():Number{
			return box.pos.y;
		}
		
		public function set mask(rect:Rectangle):void{
//			renderer.mask=rect;
		}
		
//		override public function get xGlobal():Number{
//			return 0;
//		}
//		
//		override public function get yGlobal():Number{
//			return 0;
//		}
		
		public function handDown(handId:int, x:Number, y:Number):void
		{
			 touchLayer.handDown(handId,x+xView,y+yView);
		}
		
		public function handUp(handId:int, x:Number, y:Number):void
		{
			 touchLayer.handUp(handId,x+xView,y+yView);
		}
		
		public function handMove(handId:int, x:Number, y:Number):void
		{
			 touchLayer.handMove(handId,x+xView,y+yView);
		}
		
		public function handOut(handId:int):void
		{
			 touchLayer.handOut(handId);
		}
		
	}
}
