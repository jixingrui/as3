package azura.banshee.zebra.zode.g2d
{
	import azura.banshee.g2d.AtfAtlasLoaderGAnimal2;
	import azura.banshee.g2d.AtfAtlasLoaderGLand2;
	import azura.banshee.g2d.AtfAtlasLoaderGMask2;
	import azura.banshee.g2d.BitmapDataLoaderG2d2;
	import azura.banshee.g2d.PngJpgLoaderG2d2;
	import azura.banshee.g2d.TextureLoaderBase;
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.banshee.zebra.zode.i.ZRnodeI;
	import azura.banshee.zebra.zode.i.ZRspriteI;
	import azura.common.algorithm.FastMath;
	
	import com.genome2d.components.GComponent;
	import com.genome2d.node.factory.GNodeFactory;
	
	import flash.geom.Rectangle;
	
	public class ZRnodeG2dOld extends GComponent implements ZRnodeI
	{
		public static function createNewRenderer():ZRnodeG2dOld{
			var result:ZRnodeG2dOld = GNodeFactory.createNodeWithComponent(ZRnodeG2dOld) as ZRnodeG2dOld;
			return result;
		}
		
		public function newChild():ZRnodeI
		{
			var child:ZRnodeG2dOld = createNewRenderer();
			this.node.addChild(child.node);
//			trace("Gnode count=",GStats.nodeCount,this);
			return child;
		}
		
		public function newSprite():ZRspriteI
		{
			var d:ZRspriteG2dOld = ZRspriteG2dOld.createNewRenderer();
			this.node.addChild(d.node);
//			trace("Gnode count=",GStats.nodeCount,this);
			return d;
		}
		
		public function load(sheet:ZsheetOp):void{
			//			this.sheet=sheet;
			if(sheet.textureType==ZsheetOp.PngJpg){
				sheet.loader=new PngJpgLoaderG2d2(sheet);
			}else if(sheet.textureType==ZsheetOp.BitmapData_){
				sheet.loader=new BitmapDataLoaderG2d2(sheet);
			}else if(sheet.usageType==ZsheetOp.Land){
				sheet.loader=new AtfAtlasLoaderGLand2(sheet);
			}else if(sheet.usageType==ZsheetOp.Mask){
				sheet.loader=new AtfAtlasLoaderGMask2(sheet);
			}else if(sheet.usageType==ZsheetOp.Anim){
				sheet.loader=new AtfAtlasLoaderGAnimal2(sheet);
			}
			sheet.loader.load(texReady);
		}
		
		private function texReady(loader:TextureLoaderBase):void{
//			loader.hold();
			loader.sheet.nativeTexture=loader.value;
			loader.sheet.isLoaded=true;
			loader.sheet.onLoaded.dispatch();
		}
		
		public function set visible(value:Boolean):void{
			node.transform.visible=value;	
		}
		
		public function set scaleX(value:Number):void
		{
			node.transform.scaleX=value;
		}
		
		public function set scaleY(value:Number):void
		{
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
		public function get alpha():Number{
			return node.transform.alpha;
		}
		
		public function set rotation(angle:Number):void{
			var rad:Number=FastMath.angle2radian(angle);
			node.transform.rotation=rad;	
		}
	}
}