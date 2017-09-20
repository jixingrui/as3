package azura.banshee.zbox2
{
	import azura.banshee.zbox2.engine.Zbox2ReplicaI;
	import azura.common.collections.RectC;
	import azura.touch.TouchSpace;
	import azura.touch.TouchStage;
	
	public class Zspace2 extends Zbox2
	{
		private var viewWidthScaled:int;
		private var viewHeightScaled:int;
		internal var touchSpace:TouchSpace=new TouchSpace();
		internal var key:PrivateLock=new PrivateLock();
		
		public function Zspace2(replica:Zbox2ReplicaI)
		{
			super(key, null, false);
			super.space=this;
			super.replica=replica;
			super.controller=new Zspace2ControllerEmpty();
			
			TouchStage.addLayer(touchSpace);
		}
		
		public function viewSizeScaled(width:int,height:int):void{
			viewWidthScaled=width;
			viewHeightScaled=height;
		}
		
		//viewPos1
		public function look(x:Number,y:Number):void{
			super.move(-x,-y);
		}
		
		//viewRect1
		internal function get viewRect():RectC{
			var vr:RectC=new RectC();
			vr.width=viewWidthScaled/scale;
			vr.height=viewHeightScaled/scale;
			vr.xc=viewX;
			vr.yc=viewY;
			return vr;
		}
		
		public function get scale():Number
		{
			return super.scaleLocal;
		}
		
		public function set scale(value:Number):void
		{
			touchSpace.scale=value;
			super.scaleLocal=value;
		}
				
		//=================== changed functions =================
		public function get viewX():Number{
			return -super.x;
		}
		
		public function get viewY():Number{
			return -super.y;
		}
				
		override public function get xGlobal():Number{
			return 0;
		}
		
		override public function get yGlobal():Number{
			return 0;
		}
		
		//==================== sealed functions ==============
		override public function set x(value:Number):void{
			throw new Error();
		}
		
		override public function set y(value:Number):void{
			throw new Error();
		}
		
		override public function get x():Number{
			throw new Error();
		}
		
		override public function get y():Number{
			throw new Error();
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