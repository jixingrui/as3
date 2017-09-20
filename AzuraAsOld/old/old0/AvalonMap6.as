package oldold
{
	import azura.avalon.fi.base.PyramidBase;
	import azura.avalon.fi.t256.Pyramid256;
	import azura.avalon.fi.t256.T256UserI;
	
	import common.algorithm.pathfinding.Bresenham;
	import common.algorithm.FoldIndex;
	import common.algorithm.Hexagon;
	import common.algorithm.pathfinding.LineMover;
	import common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import azura.avalon.map.AvalonMapUserI;
	
	public class AvalonMap6 implements T256UserI
	{
		private var user:AvalonMapUserI;
		
		private var pyramidContour:PyramidBase;		
		private var pyramid256Flat:Pyramid256;		
//		private var pyramidMT6:Vector.<PyramidLM>=new Vector.<PyramidLM>();
		
		private var scale:Number;
		private var _facing:int;
		private var _widthFlat:int;
		private var _heightFlat:int;
		private var sideLength:int;			
		private var xyTop:Point=new Point();
		private var mover:LineMover=new LineMover();
		
		public function AvalonMap6(user:AvalonMapUserI)
		{
			this.user=user;					
		}
		
		public function set facing(value:int):void
		{
			if(_facing!=value){
				pyramid256Flat.clear();
			}
			_facing = value;
			moveTo(xyTop.x,xyTop.y,true);
		}
		
		/**
		 * 
		 * @return scale
		 * 
		 */
		public function lookConfig(width:int,height:int,zoom:Number):Number{
			_widthFlat=width;
			_heightFlat=height;
			scale= pyramid256Flat.zoom(zoom);
			return scale;
		}
		
		public function moveTo(xTop:int,yTop:int,jump:Boolean=false):void{
			if(Hexagon.inHex(xTop,yTop,sideLength,sideLength)){
				if(jump){
//					mover.clear();
					xyTop.x=xTop;
					xyTop.y=yTop;
					var flat:Point=getXyFlat();
					pyramid256Flat.look(flat.x,flat.y,_widthFlat,_heightFlat);
					
					user._centerDepth(flat.y);
				}
				else{
//					mover=new LineMover(xyTop.x,xyTop.y,xTop,yTop);
				}
			}
		}
		
		public function frameTick():void{
//			if(mover.hasNext()){
//				xyTop=mover.next();
//				var flat:Point=getXyFlat();
//				pyramid256Flat.look(flat.x,flat.y,_widthFlat,_heightFlat);
//				
//				user._centerDepth(flat.y);
//			}
		}
		
		public function screenToTop(x:int,y:int):Point{
			var flat:Point=getXyFlat();
			flat.x=flat.x+x-_widthFlat/2;
			flat.y=flat.y+y-_heightFlat/2;
			return Hexagon.flat2top(flat.x,flat.y,sideLength,sideLength,_facing);
		}
		
		public function stumbleTo(xTop:int,yTop:int):Point{
			var b:Bresenham=new Bresenham(xyTop.x,xyTop.y,xTop,yTop,1);
			var dest:Point=xyTop.clone();
//			while(b.hasNext()){
//				var next:Point=b.next();
//				if(Hexagon.inHex(next.x,next.y,sideLength,sideLength)&&pyramidContour.walkable(next.x,next.y)){
//					dest=next;
//				}else{
//					break;
//				}
//			}
			return dest;
		}
		
		public function get zoomMax():Number{
			return pyramid256Flat.zoomMax;
		}
		
		private function getXyFlat():Point{
			return Hexagon.top2flat(xyTop.x,xyTop.y,sideLength,sideLength,_facing);
		}
		
		public function load(data:ByteArray):void{
			
			var zb:ZintBuffer=new ZintBuffer(data);			
			var layerMax:int=zb.readZint();
			sideLength=FoldIndex.getBound(layerMax)*256;
			
			pyramid256Flat=new Pyramid256(layerMax,this);	
			pyramidContour=new PyramidBase(zb.readBytes_());
			
			var zbTerrain6:Vector.<ZintBuffer>=new Vector.<ZintBuffer>();
			var zbMask6:Vector.<ZintBuffer>=new Vector.<ZintBuffer>();
			for(var i:int=0;i<6;i++){
				zbTerrain6.push(zb.readBytes_());
			}
			for(i=0;i<6;i++){
				zbMask6.push(zb.readBytes_());	
			}
			
//			for(i=0;i<6;i++){
//				var pmt:PyramidLM=new PyramidLM(layerMax,zbTerrain6[i],zbMask6[i],user);
//				pyramidMT6.push(pmt);
//			}
			
		}
		
		public function clear():void{
//			pyramid256Flat.clear();
		}
		
		public function positionTile256(fi:int, xScreen:Number, yScreen:Number):void
		{			
//			var tmt:TileLM=getTileMT(fi);
//			tmt.position(xScreen,yScreen,scale);
		}
		
		public function removeTile256(fi:int):void
		{
//			getTileMT(fi).remove();
		}
		
//		private function getTileMT(fi:int):TileLM{
//			return pyramidMT6[_facing].getTile_(fi) as TileLM;
//		}
		
	}
}