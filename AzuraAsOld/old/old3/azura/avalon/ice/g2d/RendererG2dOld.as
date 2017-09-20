package old.azura.avalon.ice.g2d
{
	import azura.banshee.loaders.g2d.AtfLoaderG2d;
	import azura.banshee.loaders.g2d.LoaderG2d;
	import azura.banshee.loaders.g2d.PackG2d;
	import azura.banshee.loaders.g2d.SubTextureLoaderG2d;
	import azura.banshee.zsheet.Ztexture;
	
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	
	import old.azura.banshee.zimage.i.ZrendererI;
	
	
	public class RendererG2dOld extends GComponent implements ZrendererI
	{
		
		private var scheduledSort:Boolean;
		
		public static function newInstance():RendererG2dOld{
			return GNodeFactory.createNodeWithComponent(RendererG2dOld) as RendererG2dOld;
		}
		
		//		public function ZimageRendererG2d(p_node:GNode)
		//		{
		////			super(p_node);
		//		}
		
		public function put(x:Number, y:Number, depth:Number):void
		{
			node.transform.x=x;
			node.transform.y=y;
			//			node.userData["depth"]=depth;
			node.userData.set("depth",depth);
		}
		
		public function set scale(value:Number):void
		{
			node.transform.scaleX=value;
			node.transform.scaleY=value;
		}
		
		public function set rotation(value:Number):void{
			node.transform.rotation=value;	
		}
		
		public function addChild(value:ZrendererI):void{
			var child:RendererG2dOld=value as RendererG2dOld;
			this.node.addChild(child.node);
		}
		
		public function removeChild(value:ZrendererI):void{
			var child:RendererG2dOld=value as RendererG2dOld;
			this.node.removeChild(child.node);
		}
		
		public function sortChildren():void{
			//			trace("ZrendererG2d: sort");
			scheduledSort=true;
		}
		
		public function enterFrame():void{
			if(scheduledSort)
				node.sortChildrenOnUserData("depth",false);
			scheduledSort=false;
		}
		
		public function load(piece:Ztexture):void{
			//			trace("load: id="+piece.id+" scale="+piece.scale+" md5="+piece.md5);
			
			var pack:PackG2d=new PackG2d();
			pack.piece=piece;
			piece.userData=pack;
			
			if(pack.piece.subTexture){
				pack.loader=new SubTextureLoaderG2d(pack);
			}else{
				pack.loader=new AtfLoaderG2d(pack);
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
			//			trace("unload "+piece.id);
			var pack:PackG2d=piece.userData as PackG2d;
			pack.loader.release(800);
		}
		public function display(piece:Ztexture):void{
			//			trace("display "+piece.id);
			var pack:PackG2d=piece.userData as PackG2d;
			
			pack.sp=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			pack.sp.node.mouseEnabled=true;
			pack.sp.node.transform.x=piece.drift.x;
			pack.sp.node.transform.y=piece.drift.y;
			pack.sp.node.transform.scaleX=piece.scale;
			pack.sp.node.transform.scaleY=piece.scale;
			pack.sp.texture=pack.loader.value as GTexture;
			if(pack.sp.texture==null)
				throw new Error("empty texture");
			if(pack.piece.textureType==Ztexture.Solid)
				pack.sp.blendMode=GBlendMode.NONE;
			//			pack.sp.node.userData["depth"]=piece.depth;
			//			pack.sp.node.userData["id"]=piece.id;
			pack.sp.node.userData.set("depth",piece.depth);
			pack.sp.node.userData.set("id",piece.id);
			
			this.node.addChild(pack.sp.node);
			//			trace(piece.drift);
		}
		public function undisplay(piece:Ztexture):void{
			//			trace("undisplay "+piece.id);
			var pack:PackG2d=piece.userData as PackG2d;
			this.node.removeChild(pack.sp.node);
			pack.sp.texture=null;
		}
		public function hide(piece:Ztexture):void{
			//			trace("hide "+piece.id);
			var pack:PackG2d=piece.userData as PackG2d;
			if(!pack.piece.textureType==Ztexture.Empty)
				pack.sp.node.transform.visible=false;
		}
		public function unhide(piece:Ztexture):void{
			//			trace("show "+piece.id);
			var pack:PackG2d=piece.userData as PackG2d;
			if(!pack.piece.textureType==Ztexture.Empty)
				pack.sp.node.transform.visible=true;
		}
		public function clear():void{
			//			trace("clear");
		}
	}
}