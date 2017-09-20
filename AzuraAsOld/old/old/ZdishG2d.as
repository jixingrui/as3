package azura.pyramid.g2d
{
	import azura.banshee.ice.dish.TextureType;
	import azura.banshee.ice.land.PyramidLand;
	import azura.banshee.ice.land.TileLand;
	import azura.banshee.zimage.Zimage;
	import azura.banshee.zimage.i.ZimageRendererI;
	import azura.banshee.zsheet.Ztexture;
	import azura.pyramid.loader.LoaderG2d;
	import azura.pyramid.loader.PackG2d;
	import azura.pyramid.loader.SubTextureLoaderG2d;
	import azura.pyramid.loader.TextureLoaderG2d;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.node.GNode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	
	import flash.utils.Dictionary;
	
	public class ZdishG2d extends ZplateG2d implements ZimageRendererI
	{
		public function ZdishG2d(p_node:GNode)
		{
			super(p_node);
		}
		
		public function load(piece:Ztexture):void{
//			trace("load="+piece.id+" x="+piece.x+" y="+piece.y+" scale="+piece.scale+" md5="+piece.md5);
			
			var pack:PackG2d=new PackG2d();
			pack.piece=piece;
			piece.userData=pack;
			
			if(pack.piece.subTexture){
				pack.loader=new SubTextureLoaderG2d(pack);
			}else{
				pack.loader=new TextureLoaderG2d(pack);
			}
			pack.loader.load(texLoaded);
		}
		
		private function texLoaded(loader:LoaderG2d):void{
			loader.hold();
			var pack:PackG2d=loader.pack;
			pack.piece.ready();
//			trace("ready "+pack.piece.id);
		}
		public function unload(piece:Ztexture):void{
			var pack:PackG2d=piece.userData as PackG2d;
			pack.loader.release(800);
//			trace("release "+piece.id);
		}
		public function display(piece:Ztexture):void{
			var pack:PackG2d=piece.userData as PackG2d;
			
			pack.sp=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			this.node.addChild(pack.sp.node);
			pack.sp.node.mouseEnabled=true;
			pack.sp.node.transform.x=piece.drift.x;
			pack.sp.node.transform.y=piece.drift.y;
			pack.sp.node.transform.scaleX=piece.scale;
			pack.sp.node.transform.scaleY=piece.scale;
			pack.sp.texture=pack.loader.value as GTexture;
			if(pack.piece.textureType==TextureType.Solid)
				pack.sp.blendMode=GBlendMode.NONE;
			pack.sp.node.userData["depth"]=piece.depth;
//			this.node.sortChildrenOnUserData("depth",false);
//			trace(piece.drift);
		}
		public function remove(piece:Ztexture):void{
			var pack:PackG2d=piece.userData as PackG2d;
			this.node.removeChild(pack.sp.node);
			pack.sp.texture=null;
		}
		public function reveal(piece:Ztexture):void{
//			trace("show "+piece.id);
//			var pack:Pack=piece.userData as Pack;
//			if(!pack.piece.textureType==PlateType.Empty)
//				pack.sp.node.transform.visible=true;
		}
		public function hide(piece:Ztexture):void{
//			trace("hide "+piece.id);
//			var pack:Pack=piece.userData as Pack;
//			if(!pack.piece.textureType==PlateType.Empty)
//				pack.sp.node.transform.visible=false;
		}
		public function clear():void{
			
		}
	}
}