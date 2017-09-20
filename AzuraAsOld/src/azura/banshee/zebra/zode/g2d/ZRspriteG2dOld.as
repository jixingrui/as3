package azura.banshee.zebra.zode.g2d
{
	import azura.banshee.g2d.AtfAtlasLoaderGAnimal2;
	import azura.banshee.g2d.AtfAtlasLoaderGLand2;
	import azura.banshee.g2d.AtfAtlasLoaderGMask2;
	import azura.banshee.g2d.BitmapDataLoaderG2d2;
	import azura.banshee.g2d.PngJpgLoaderG2d2;
	import azura.banshee.g2d.TextureLoaderBase;
	import azura.banshee.g2d.old.AtfLoaderG2d2;
	import azura.banshee.zebra.zode.ZframeOp;
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.banshee.zebra.zode.i.ZRspriteI;
	
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	
	public class ZRspriteG2dOld extends GSprite implements ZRspriteI
	{
		
		public static function createNewRenderer():ZRspriteG2dOld{
			var result:ZRspriteG2dOld = GNodeFactory.createNodeWithComponent(ZRspriteG2dOld) as ZRspriteG2dOld;
			return result;
		}
		
		//		private var sheet:Ztexture;
		
		
		
		public function display(sub:ZframeOp):void{
			if(sub.sheet.textureType==ZsheetOp.Solid)
				blendMode=GBlendMode.NONE;
			
			node.userData.set("depth",sub.depth);
			node.transform.x=sub.driftX;
			node.transform.y=sub.driftY;
			node.transform.scaleX=sub.scale;
			node.transform.scaleY=sub.scale;
			node.transform.alpha=sub.alpha;
			
			//			trace("sprite scale",sub.scale,this);
			
			texture=sub.sheet.nativeTexture as GTexture;
			if(texture==null){
				var atlas:GTextureAtlas=sub.sheet.nativeTexture as GTextureAtlas;
				texture=atlas.getSubTexture(sub.subId);
				if(texture==null)
					texture=atlas.addSubTexture(sub.subId,sub.rectOnSheet,0,0,sub.rectOnSheet.width,sub.rectOnSheet.height);
			}
			//			if(sub.sheet.isAtlas){
			//			}else{
			//				texture=sub.sheet.nativeTexture as GTexture;
			//			}
		}
		
		public function set visible(value:Boolean):void{
			node.transform.visible=value;
		}
		
		//		public function set rotation(angle:Number):void{
		//			var rad:Number=FastMath.toRadians(angle);
		//			node.transform.rotation=rad;	
		//		}
		
		public function clear():void{
			texture=null;
		}
		
		override public function dispose():void{
			clear();
			super.dispose();
		}
		
	}
}



//============================== old =============================

//		public function displayOld(zd:Zsprite):void{

//			zd.onDisplay=true;			
//			var pack:LoaderPackG2d=zd.userData as LoaderPackG2d;
//			
//			//			if(pack.gs==null){
//			//				pack.gs=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
//			//			}
//			
//			if(pack.zd.textureType==ZnodeDisplay.Solid)
//				blendMode=GBlendMode.NONE;
//			
//			node.userData.set("depth",zd.depth);
//			node.transform.x=zd.drift.x;
//			node.transform.y=zd.drift.y;
//			node.transform.scaleX=zd.scale;
//			node.transform.scaleY=zd.scale;
//			node.transform.alpha=zd.alpha;
//			//			node.addChild(pack.gs.node);
//			
//			//			sortChildren();
//			
//			if(pack.loader.value==null)
//				return;
//			
//			if(pack.zd.atlas){
//				var atlas:GTextureAtlas=pack.loader.value as GTextureAtlas;
//				texture=atlas.getSubTexture(pack.zd.id.toString());
//				if(texture==null)
//					texture=atlas.addSubTexture(pack.zd.id.toString(),pack.zd.rectOnTexture);
//			}else{
//				texture=pack.loader.value as GTexture;
//			}

//		}
//		public function undisplay(zd:Zsprite):void{
//			trace("undisplay",zd.key,this);
//			if(zd.onDisplay){
//				zd.onDisplay=false;				
//				var pack:LoaderPackG2d=zd.userData as LoaderPackG2d;
//				node.removeChild(pack.gs.node);
//			}
//		}
//		public function hide(zd:Zsprite):void{
//			var pack:LoaderPackG2d=zd.userData as LoaderPackG2d;
//			if(pack.zd.textureType!=ZnodeDisplay.Empty)
//				node.transform.visible=false;
//		}
//		public function unhide(zd:Zsprite):void{
//			var pack:LoaderPackG2d=zd.userData as LoaderPackG2d;
//			if(pack.zd.textureType!=ZnodeDisplay.Empty)
//				node.transform.visible=true;
//		}


//		public function loadOld(zd:Zsprite):void{
//			trace("load",zd.key,this);
//			var pack:LoaderPackG2d=new LoaderPackG2d();
//			pack.zd=zd;
//			zd.userData=pack;
//			
//			if(pack.zd.textureType==ZnodeDisplay.Original){
//				pack.loader=new BitmapDataLoaderRemoteG2d(pack);
//			}else if(pack.zd.textureType==ZnodeDisplay.BitmapData){
//				pack.loader=new BitmapDataLoaderLocalG2d(pack);
//			}else if(pack.zd.atlas){
//				if(pack.zd.isMask)
//					pack.loader=new AtfAtlasLoaderGMask(pack);
//				else
//					pack.loader=new AtfAtlasLoaderGAnimal(pack);
//			}else{
//				pack.loader=new AtfLoaderG2d(pack);
//			}
//			pack.loader.load(texLoaded);
//		}

//		private function texLoaded(loader:LoaderG2d):void{
//			loader.hold();
//			var pack:LoaderPackG2d=loader.pack;
//			pack.zd.texReady();
//		}


//		public function unloadOld(zd:Zsprite):void{
//			var pack:LoaderPackG2d=zd.userData as LoaderPackG2d;
//			pack.loader.release(60000);
//			if(pack.gs!=null)
//				pack.gs.dispose();
//			else
//				trace("todo: unload before loaded",this);
//		}

//		public function cancelOld(zd:Zsprite):void{
//			trace("cancel "+zd.key,this);
//			var pack:LoaderPackG2d=zd.userData as LoaderPackG2d;
//			pack.loader.release();
//		}