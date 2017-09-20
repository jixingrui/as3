package azura.banshee.zbox2.engine.starling
{
	import azura.banshee.engine.video.VideoI;
	import azura.banshee.engine.video.VideoStarling;
	import azura.banshee.zbox2.engine.Zbox2ReplicaI;
	import azura.banshee.zebra.branch.ZbitmapI;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.banshee.zebra.data.wrap.Zframe2I;
	import azura.banshee.zebra.data.wrap.Zsheet2;
	import azura.common.algorithm.FastMath;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class Zbox2ReplicaStarling implements Zbox2ReplicaI
	{
		private static var sheet_Loader:Dictionary=new Dictionary();
		
		public var node:Sprite;
		public var displayer:Image;
		
		public function Zbox2ReplicaStarling(parent:Sprite){
			node=new Sprite();
			parent.addChild(node);
		}
		
		public function replicate():Zbox2ReplicaI
		{
			return new Zbox2ReplicaStarling(node);
		}
		
		public function addChild(child:Zbox2ReplicaI):void
		{
			var c:Zbox2ReplicaStarling=child as Zbox2ReplicaStarling;
			if(node.getChildIndex(c.node)!=-1){
				trace("Error: duplicate add child",this);
				return;
			}
			node.addChild(c.node);
		}
		
		public function removeChild(child:Zbox2ReplicaI):void
		{
			var c:Zbox2ReplicaStarling=child as Zbox2ReplicaStarling;
			node.removeChild(c.node);
		}
		
		public function swapChildren(idx1:int, idx2:int):void
		{
			node.swapChildrenAt(idx1,idx2);
		}
		
		public function loadFrameFromSheet(zframe:Zframe2):void
		{
			if(zframe.nativeTexture!=null)
				throw new Error();
			
			if(zframe.sheet.sheetTexture==null)
				throw new Error();
			
			var atlas:Texture=zframe.sheet.sheetTexture as Texture;
			zframe.nativeTexture_=Texture.fromTexture(atlas,zframe.rectOnSheet);
			zframe.frameLoaded();
		}
		
		public function unloadFrameFromSheet(zframe:Zframe2):void
		{
			Texture(zframe.nativeTexture).dispose();
			zframe.nativeTexture_=null;
		}
		
		public function loadSheet(zsheet:Zsheet2):void
		{			
			var loader:StarlingAtf=new StarlingAtf(zsheet,0);
			sheet_Loader[zsheet]=loader;
			loader.load(sheetLoaded);
			function sheetLoaded(loader:StarlingAtf):void{
//				loader.sheet.sheetLoaded(loader.value);
			}
		}
		
		public function unloadSheet(zsheet:Zsheet2):void
		{
			var loader:StarlingAtf=sheet_Loader[zsheet];
			loader.release(100000);
			delete sheet_Loader[zsheet];
		}
		
		public function fromBitmap(source:ZbitmapI):void
		{
			source.nativeTexture=Texture.fromBitmapData(source.bitmapData);
		}
		
		public function unloadBitmap(source:ZbitmapI):void
		{
			var tex:Texture=source.nativeTexture as Texture;
			tex.dispose();
			source.nativeTexture =null;
		}
		
		public function loadFromVideoUrlOld(url:String,ret_null:Function=null):VideoI{
			var vs:VideoStarling=new VideoStarling(url);
			vs.load(loaded);
			function loaded(vs_:VideoStarling):void{
				if(displayer==null){
					displayer=new Image(vs_.value as Texture);
					
//					displayer.smoothing=TextureSmoothing.NONE;
					displayer.textureSmoothing=TextureSmoothing.NONE;
					
					node.addChild(displayer);
				}
				displayer.texture=vs_.value as Texture;
				displayer.x=Math.round(-displayer.width/2);
				displayer.y=Math.round(-displayer.height/2);
				//				trace("displayer.y=",displayer.y,this);
			}
			return vs;
		}
		
//		public function loadVideo(source:Zbox3LoaderLinkVideo):void{
//			
//		}
		
		public function set clipRect(rect:Rectangle):void
		{
//			node.clipRect=rect;
			var quad:Quad=new Quad(rect.width,rect.height);
			quad.x=rect.x;
			quad.y=rect.y;
			node.mask=quad;
		}
		
		public function display(target:Zframe2I):void
		{
			//			trace("display",this);
			var f:Zframe2=target as Zframe2;
			if(f!=null && (f.boundingBox.width==0||f.boundingBox.height==0)){
				//				trace("skip",this);
				return;
			}
			
			if(displayer==null){
				displayer=new Image(target.nativeTexture as Texture);
				
//				if(target.smoothing)
//					displayer.smoothing=TextureSmoothing.BILINEAR;
//				else
//					displayer.smoothing=TextureSmoothing.NONE;
				
//				if(target.smoothing)
//					displayer.textureSmoothing=TextureSmoothing.BILINEAR;
//				else
//					displayer.textureSmoothing=TextureSmoothing.NONE;
				
				node.addChild(displayer);
			}
			displayer.texture=target.nativeTexture as Texture;
			displayer.x=Math.round(-target.dx-displayer.width/2);
			displayer.y=Math.round(-target.dy-displayer.height/2);
			//			displayer.y=-target.dy-displayer.height/2;
			//			trace("displayer.y=",displayer.y,this);
		}
		
		public function unDisplay():void
		{
			//			trace("undisplay",this);
			if(displayer!=null){
				node.removeChild(displayer);				
				displayer.dispose();
				displayer=null;
			}
		}
		
		public function set visible(value:Boolean):void
		{
			//			trace("visible=",value,this);
			node.visible=value;
		}
		
		public function get visible():Boolean
		{
			return node.visible;
		}
		
		public function set alpha(value:Number):void
		{
			node.alpha=value;
		}
		
		public function set scaleX(value:Number):void
		{
			node.scaleX=value;
			//			trace("scaleX",value,this);
		}
		
		public function set scaleY(value:Number):void
		{
			node.scaleY=value;
			//			trace("scaleY",value,this);
		}
		
		public function set rotation(angle:Number):void
		{
			var rad:Number=FastMath.angle2radian(angle);
			node.rotation=rad;
		}
		
		public function set x(value:Number):void
		{
			node.x=Math.round(value);
		}
		
		public function set y(value:Number):void
		{
			node.y=Math.round(value);
			//			node.y=value;
		}
		
		public function set width(value:Number):void{
			//			node.width=value;
			displayer.x+=displayer.width/2;
			displayer.width=value;
			displayer.x-=displayer.width/2;
		}
		
		public function set height(value:Number):void{
			displayer.y+=displayer.height/2;
			displayer.height=value;
			displayer.y-=displayer.height/2;
			//			node.height=value;
		}
	}
}