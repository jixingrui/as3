package azura.avalon.fi.t256.old
{
	import azura.common.algorithm.FoldIndex;
	
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	
	import flash.geom.Rectangle;
	
	import spark.effects.Scale;
	
	public class Pyramid256 extends PyramidFi
	{		
		private var user:T256UserI;		
		
		private var scale:Number;
		private var layerOld:int=-1;
		private var layerNew:int;
		private var viewOld:Rectangle=new Rectangle();
		
		public function Pyramid256(layerMax:int,user:T256UserI)
		{
			init(layerMax);
			this.user=user;
			zoom(1);
		}
		
		private function z2floor(z:Number):int{
			z=Math.max(1,z);
			var layer:int=Math.log(z)/Math.log(2);
			return layer;
		}
		
		private function z2scale(z:Number):Number{
			z=Math.max(0.1,z);
			var floor:int=z2floor(z);
			var scale:Number=Math.pow(2,floor)/z;				
			scale=Math.round(scale*256)/256;
			return scale;
		}
		
		public function get zoomMax():Number{
			return Math.pow(2,zMax);
		}
		
		public function clear():void{
			for each(var tile:Tile256 in getOverlapTiles(viewOld,layerOld)){	
				user.removeTile256(tile.fi.fi);
			}
			layerOld=-1;
		}
		
		/**
		 * 
		 * @param z 
		 * z=1/magnify
		 * 
		 */
		public function zoom(z:Number):Number{
			z=Math.min(zoomMax,z);
			layerNew=zMax-z2floor(z);
			scale=z2scale(z);
			return scale;
		}		
		
		public function look(xc:int,yc:int,width:int,height:int):void{
			
			var layerScale:int=Math.pow(2,zMax-layerNew);
			xc/=layerScale;
			yc/=layerScale;
			
			var viewNew:Rectangle=new Rectangle();	
			viewNew.x=xc-width/scale/2;
			viewNew.y=yc-height/scale/2;
			viewNew.width=width/scale;
			viewNew.height=height/scale;		
			
			var tile:Tile256;
			if(layerNew!=layerOld){				
				if(layerOld!=-1){					
					for each(tile in getOverlapTiles(viewOld,layerOld)){	
						user.removeTile256(tile.fi.fi);
					}
				}
				
				for each(tile in getOverlapTiles(viewNew,layerNew)){
					position(tile,viewNew,scale);
				}
				
				layerOld=layerNew;
			}else{
				var union:Rectangle=viewNew.union(viewOld);
				
				for each(tile in getOverlapTiles(union,layerOld)){
					var inOld:Boolean=tile.intersects(viewOld);
					var inNew:Boolean=tile.intersects(viewNew);
					if(inNew){		
						position(tile,viewNew,scale);
					}else if(inOld){
						user.removeTile256(tile.fi.fi);
					}
				}				
			}
			viewOld=viewNew;
		}
		
		private function position(tile:Tile256,view:Rectangle,scale:Number):void{
			var xScreen:Number=(tile.x-view.x)*scale;
			var yScreen:Number=(tile.y-view.y)*scale;
//			user.positionTile256(tile.fi,xScreen,yScreen);
			user.positionTile256(tile.fi.fi,tile.x,tile.y);
		}
		
		private function getOverlapTiles(rect256:Rectangle,layer:int):Vector.<Tile256>{
			var side:int=FoldIndex.getBound(layer);
			
			var xFrom:int=Math.max(0,rect256.x/256);
			var xTo:int=Math.min(Math.ceil(rect256.right/256),side);
			var yFrom:int=Math.max(0,rect256.y/256);
			var yTo:int=Math.min(Math.ceil(rect256.bottom/256),side);
			
			var result:Vector.<Tile256>=new Vector.<Tile256>();
			for(var i:int=xFrom;i<xTo;i++)
				for(var j:int=yFrom;j<yTo;j++){
					var tile:Tile256=getTile(i,j,layer) as Tile256;
					result.push(tile);
				}
			return result;
		}		
		
		private function sideLength(layer:int):int{
			return FoldIndex.getBound(layer)*256;
		}
		
		private function rectLayer(layer:int):Rectangle{
			return new Rectangle(0,0,sideLength(layer),sideLength(layer));
		}
		
		override public function createTile(fi:int):TileFi{
			return new Tile256(fi,this);
		}
	}
}