package azura.banshee.zebra.zode
{
	import azura.banshee.zebra.zode.i.ZRspriteI;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Zshard
	{
		public var host:ZboxOld;
		protected var renderer:ZRspriteI;
		private var bb:Rectangle;
		
		public function Zshard(host:ZboxOld){
			this.host=host;
			host.shardList.push(this);
			this.renderer=host.renderer.newSprite();
		}
		
		public function getBB(axis:Point,angle:Number):Rectangle{
			var rad:Number=FastMath.angle2radian(angle);
			return FastMath.rotateRectangle(axis,bb,rad);
		}
		
		public function display(zs:ZframeOp):void{
			bb=zs.boundingBox;
			renderer.display(zs);
			host.renderer.sortChildren();
		}
		
		public function set visible(value:Boolean):void{
			renderer.visible=value;
		}
		
		public function clear():void{
			renderer.clear();
		}
		
		public function dispose():void{
			renderer.dispose();
			host.removeDisplay(this);
			renderer=null;
			host=null;
		}
	}
}

//===================================== old ====================================
//		public function zUpChange(value:int):void{
//			trace("zUp change to",value,this);
//		}
//		public function undisplay():void{
//			renderer.undisplay(this);
//		}

//		public function hide():void{
//			renderer.hide(this);
//		}
//		
//		public function unhide():void{
//			renderer.unhide(this);
//		}

//		public function unload():void{
//			renderer.unloadOld(this);
//			parent.renderer.removeDisplay(renderer);
//		}

//		public function cancel():void{
//			renderer.cancelOld(this);
//		}


//		public static var Init:int=0;
//		public static var Empty:int=1;
//		public static var Alpha:int=2;
//		public static var Solid:int=3;
//		public static var Original:int=4;
//		public static var BitmapData:int=5;

//		public var textureType:int=Alpha;
//		public var id:int;
//		public var mc5:String;
//		public var alpha:Number=1;
//		public var atlas:Boolean;
//		public var isMask:Boolean;

//		public var userData:Object;
//		public var bd:*;
//		public var mouseEnabled:Boolean=true;
//		public var loadingPriority:int;

//		public var scale:Number=1;
//		public var rectOnTexture:Rectangle=new Rectangle();
//		private var _boundingBox:Rectangle;
/**
 * The distance that the texture should move when display.
 */
//		public var drift:Point=new Point();
//		public var depth:int;

//		public var onDisplay:Boolean;
//		public var onTexReady:Signal=new Signal(ZnodeDisplay);

//		public function get boundingBox():Rectangle
//		{
//			return _boundingBox;
//		}
//
//		public function set boundingBox(value:Rectangle):void
//		{
//			_boundingBox = value;
//			zbox.boundingBox=value;
//		}

//		public function texReady():void{
//			onTexReady.dispatch(this);
//		}

//		public function get key():String{
//			return mc5+"_"+id;
//		}