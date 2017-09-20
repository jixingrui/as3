package azura.banshee.engine.g2d
{
	import azura.banshee.loaders.g2d.AtfAtlasLoaderG;
	import azura.banshee.loaders.g2d.AtfAtlasLoaderGAnimal;
	import azura.banshee.loaders.g2d.AtfAtlasLoaderGMask;
	import azura.banshee.loaders.g2d.AtfLoaderG2d;
	import azura.banshee.loaders.g2d.BitmapDataLoaderLocalG2d;
	import azura.banshee.loaders.g2d.BitmapDataLoaderRemoteG2d;
	import azura.banshee.loaders.g2d.LoaderG2d;
	import azura.banshee.loaders.g2d.LoaderPackG2d;
	import azura.banshee.zode.ZnodeDisplay;
	import azura.banshee.zode.ZrDisplayI;
	import azura.common.algorithm.FastMath;
	
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.context.stats.GStats;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	
	import flash.geom.Rectangle;
	
	public class ZrendererG2d extends GComponent implements ZrDisplayI
	{
		
		public static function createNewRenderer():ZrendererG2d{
			var result:ZrendererG2d = GNodeFactory.createNodeWithComponent(ZrendererG2d) as ZrendererG2d;
			return result;
		}
		
		public function createNew():ZrDisplayI{
			return createNewRenderer();
		}
		
		public function set rotation(angle:int):void{
			var rad:Number=FastMath.toRadians(angle);
			node.transform.rotation=rad;	
		}
		
		//		private static var count:int;
		public function addChild(value:ZrDisplayI):void{
			trace("Gnode count=",GStats.nodeCount,this);
			var child:ZrendererG2d=value as ZrendererG2d;
			this.node.addChild(child.node);
		}
		
		public function removeChild(value:ZrDisplayI):void{
			//			trace("Gnode count=",--count,this);
			var child:ZrendererG2d=value as ZrendererG2d;
			this.node.removeChild(child.node);
		}
		
		public function set visible(value:Boolean):void{
			node.transform.visible=value;	
		}
		
		public function set scale(value:Number):void
		{
			node.transform.scaleX=value;
			node.transform.scaleY=value;
		}
		
		public function move(x:Number, y:Number, depth:Number):void
		{
			node.transform.x=x;
			node.transform.y=y;
			node.userData.set("depth",depth);
		}
		
		private var scheduledSort:Boolean;
		public function sortChildren():void{
			scheduledSort=true;
		}
		
		public function enterFrame():void{
			if(scheduledSort){
				node.sortChildrenOnUserData("depth",false);
				scheduledSort=false;
			}
		}
		
		public function set mask(rect:Rectangle):void{
			node.maskRect=rect;
		}
		
		public function set alpha(value:Number):void{
			node.transform.alpha=value;
		}
		
		public function load(piece:ZnodeDisplay):void{
			//			trace("load",piece.key,this);
			var pack:LoaderPackG2d=new LoaderPackG2d();
			pack.zd=piece;
			piece.userData=pack;
			
			if(pack.zd.textureType==ZnodeDisplay.Original){
				pack.loader=new BitmapDataLoaderRemoteG2d(pack);
			}else if(pack.zd.textureType==ZnodeDisplay.BitmapData){
				pack.loader=new BitmapDataLoaderLocalG2d(pack);
			}else if(pack.zd.atlas){
				if(pack.zd.isMask)
					pack.loader=new AtfAtlasLoaderGMask(pack);
				else
					pack.loader=new AtfAtlasLoaderGAnimal(pack);
			}else{
				pack.loader=new AtfLoaderG2d(pack);
			}
			pack.loader.load(texLoaded);
		}
		
		//		private static var rn:int;
		private function texLoaded(loader:LoaderG2d):void{
			//			rn++;
			//			trace("loaded",loader.pack.piece.key,this);
			loader.hold();
			var pack:LoaderPackG2d=loader.pack;
			pack.zd.texReady();
		}
		
		public function unload(zd:ZnodeDisplay):void{
			//			rn--;
			//			trace("==== total loaded:",rn,this);
			//			trace("unload",zd.key,this);
			var pack:LoaderPackG2d=zd.userData as LoaderPackG2d;
			pack.loader.release(60000);
			if(pack.gs!=null)
				pack.gs.dispose();
			else
				trace("todo: unload before loaded",this);
		}
		
		public function cancel(piece:ZnodeDisplay):void{
			trace("cancel "+piece.key,this);
			var pack:LoaderPackG2d=piece.userData as LoaderPackG2d;
			pack.loader.release();
		}
		
		public function display(piece:ZnodeDisplay):void{
			//			trace("display",this);
			
			piece.onDisplay=true;			
			var pack:LoaderPackG2d=piece.userData as LoaderPackG2d;
			
			if(pack.gs==null){
				pack.gs=GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
			}
			
			node.userData.set("depth",piece.depth);
			node.transform.x=piece.drift.x;
			node.transform.y=piece.drift.y;
			node.transform.scaleX=piece.scale;
			node.transform.scaleY=piece.scale;
			node.transform.alpha=piece.alpha;
			node.addChild(pack.gs.node);
			
			sortChildren();
			
			if(pack.zd.atlas){
				var atlas:GTextureAtlas=pack.loader.value as GTextureAtlas;
				pack.gs.texture=atlas.getSubTexture(pack.zd.id.toString());
				if(pack.gs.texture==null)
					pack.gs.texture=atlas.addSubTexture(pack.zd.id.toString(),pack.zd.rectOnTexture);
			}else{
				pack.gs.texture=pack.loader.value as GTexture;
			}
			
			if(pack.zd.textureType==ZnodeDisplay.Solid)
				pack.gs.blendMode=GBlendMode.NONE;
		}
		public function undisplay(piece:ZnodeDisplay):void{
			//			trace("undisplay",piece.key,this);
			if(piece.onDisplay){
				piece.onDisplay=false;				
				var pack:LoaderPackG2d=piece.userData as LoaderPackG2d;
				node.removeChild(pack.gs.node);
			}
		}
		public function hide(piece:ZnodeDisplay):void{
			var pack:LoaderPackG2d=piece.userData as LoaderPackG2d;
			if(pack.zd.textureType!=ZnodeDisplay.Empty)
				pack.gs.node.transform.visible=false;
		}
		public function unhide(piece:ZnodeDisplay):void{
			var pack:LoaderPackG2d=piece.userData as LoaderPackG2d;
			if(pack.zd.textureType!=ZnodeDisplay.Empty)
				pack.gs.node.transform.visible=true;
		}
		public function clear():void{
			trace(this,"clear for nothing");
		}
	}
}