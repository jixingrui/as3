package azura.banshee.zbox2.engine.g2d
{
	import azura.banshee.engine.video.VideoI;
	import azura.banshee.zbox2.engine.Zbox2ReplicaI;
	import azura.banshee.zebra.branch.ZbitmapI;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.banshee.zebra.data.wrap.Zframe2I;
	import azura.banshee.zebra.data.wrap.Zsheet2;
	import azura.common.algorithm.FastMath;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.utils.UIDUtil;
	
	public class Zbox2ReplicaG2d implements Zbox2ReplicaI
	{
		public var node:GNode;
		private var displayer:GSprite;
		
		private static var sheet_Loader:Dictionary=new Dictionary();
		
		private var scaleX_:Number=1;
		private var scaleY_:Number=1;
		
		public function Zbox2ReplicaG2d(){
			node=GNodeFactory.createNode();
		}
		
		public function set clipRect(rect:Rectangle):void
		{
		}
		
		public function replicate():Zbox2ReplicaI
		{
			return new Zbox2ReplicaG2d();
		}
		
		public function addChild(child:Zbox2ReplicaI):void{
			var c:Zbox2ReplicaG2d=child as Zbox2ReplicaG2d;
			node.addChild(c.node);
		}
		
		public function removeChild(child:Zbox2ReplicaI):void
		{
			var c:Zbox2ReplicaG2d=child as Zbox2ReplicaG2d;
			node.removeChild(c.node);
		}
		
		public function swapChildren(idx1:int, idx2:int):void
		{
			node.swapChildrenAt(idx1,idx2);
		}
		
		public function fromBitmap(source:ZbitmapI):void{
			var uid:String=UIDUtil.createUID();
			var tex:GTexture=GTextureFactory.createFromBitmapData(uid,source.bitmapData);
			source.nativeTexture=tex;
		}
		
		public function unloadBitmap(source:ZbitmapI):void{
			var tex:GTexture=source.nativeTexture as GTexture;
			tex.dispose();
			source.nativeTexture=null;
		}
		
		public function loadFromVideoUrlOld(url:String,ret_null:Function=null):VideoI{
			return null;
		}
		
		public function loadFrameFromSheet(frame:Zframe2):void{
//			trace("load frame",frame,frame.sheet,frame.idxInAtlas,this);
			if(frame.nativeTexture!=null)
				throw new Error();
			
			if(frame.sheet.sheetTexture==null)
				throw new Error();
			
			var ga:GTextureAtlas=frame.sheet.sheetTexture as GTextureAtlas;
			var texture:GTexture=ga.getSubTexture(frame.idxInAtlas.toString());
			if(texture==null)
				texture=ga.addSubTexture(frame.idxInAtlas.toString(),frame.rectOnSheet,0,0,frame.rectOnSheet.width,frame.rectOnSheet.height);
			frame.nativeTexture_=texture;
			frame.frameLoaded();
		}
		
		public function unloadFrameFromSheet(frame:Zframe2):void{
//			trace("unload frame",frame,frame.sheet,frame.idxInAtlas,this);
			var ga:GTextureAtlas=frame.sheet.sheetTexture as GTextureAtlas;
			if(ga==null)
				throw new Error();
//			if(atlas.getSubTexture(frame.idxInAtlas.toString())==null)
//				throw new Error();
//			atlas.removeSubTexture(frame.idxInAtlas.toString());
			frame.nativeTexture_=null;
			//=============== warning: subtexture not removed ===========
		}
		
		public function loadSheet(zsheet:Zsheet2):void{
			//			trace("load sheet",this);
			var loader:SheetLoaderG2d2=new SheetLoaderG2d2(zsheet,0);
			sheet_Loader[zsheet]=loader;
			loader.load(sheetLoaded);
			function sheetLoaded(loader:SheetLoaderG2d2):void{
//				loader.sheet.sheetLoaded(loader.value);
			}
		}
		
		public function unloadSheet(zsheet:Zsheet2):void{
			//			trace("unload sheet",this);
			var loader:SheetLoaderG2d2=sheet_Loader[zsheet];
			loader.release(1000);
			delete sheet_Loader[zsheet];
		}
		
//		public function loadVideo(source:Zbox3LoaderLinkVideo):void{
//			
//		}
		
		public function display(target:Zframe2I):void
		{
			if(displayer==null){
				displayer=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
				this.node.addChild(displayer.node);
			}
			displayer.texture=target.nativeTexture as GTexture;
			if(displayer.texture==null)
				throw new Error();
			displayer.node.transform.x=-target.dx;
			displayer.node.transform.y=-target.dy;
			//								trace(frameDisplaying.anchor,this);
			updateX();
			updateY();
		}
		
		public function unDisplay():void
		{
			if(displayer!=null){
//				trace("replica: undisplay",this);
				displayer.texture=null;
			}
		}
		
		public function set alpha(value:Number):void{
			node.transform.alpha=value;
		}
		
		public function set visible(value:Boolean):void
		{
			node.transform.visible=value;
		}
		
		public function get visible():Boolean{
			return node.transform.visible;
		}
		
		public function set scaleX(value:Number):void{
			scaleX_=value;
			updateX();
		}
		
		public function set scaleY(value:Number):void{
			scaleY_=value;
			updateY();
		}
		
		private function updateX():void{			
			this.node.transform.scaleX=scaleX_;
		}
		
		private function updateY():void{	
			this.node.transform.scaleY=scaleY_;
		}
		
		public function set rotation(angle:Number):void{
			var rad:Number=FastMath.angle2radian(angle);
			node.transform.rotation=rad;
		}
		
		public function set x(value:Number):void{
			node.transform.x=value;
		}
		
		public function set y(value:Number):void{
			node.transform.y=value;
		}
		
		public function set width(value:Number):void{
			
		}
		
		public function set height(value:Number):void{
			
		}
	}
}