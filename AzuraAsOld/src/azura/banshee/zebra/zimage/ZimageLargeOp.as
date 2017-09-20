package azura.banshee.zebra.zimage
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.PyramidViewer;
	import azura.avalon.fi.view.PyramidViewerI;
	import azura.banshee.zebra.i.ZimageOpI;
	import azura.banshee.zebra.node.ZimageNode;
	import azura.banshee.zebra.zode.ZsheetOp;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class ZimageLargeOp implements ZimageOpI,PyramidViewerI
	{
		private var bsLoading:FiSet= new FiSet();
		
		private var fi_ZimageLargeTileSprite:Dictionary=new Dictionary();
		
		private var zUp_:int;
		
		internal var host:ZimageNode;
		
		private var pyramid:ZimageLarge;
		
		private var viewer:PyramidViewer;
		
		public function ZimageLargeOp(host:ZimageNode)
		{
			this.host=host;
			viewer=new PyramidViewer(this,false);
		}
		
		public function clear():void{
			viewer.clear();
		}
		
		public function dispose():void{
			viewer.clear();
			viewer=null;
			bsLoading=null;
			fi_ZimageLargeTileSprite=null;
		}
		
		public function set data(pyramid:ZimageLarge):void{
			this.pyramid=pyramid;
			clear();
		}
		
		public function get zUp():int{
			return zUp_;
		}
		
		public function set zUp(value:int):void
		{
			if(z<0)
				throw new Error();
			zUp_ = value;
			
			viewer.clear();
			viewer.z=z;
		}
		
		/**
		 * 
		 * @return [0...16]
		 * 
		 */
		public function get layerCount():int{
			return pyramid.zMax+1;
		}
		
		private function get z():int{
			return pyramid.zMax-zUp_;
		}
		
		public function look(viewLocal:Rectangle):void {
			viewLocal=viewLocal.clone();
			
			var scale:Number=FastMath.pow2x(zUp_);
			
			viewLocal.x/=256*scale;
			viewLocal.y/=256*scale;
			viewLocal.width/=256*scale;
			viewLocal.height/=256*scale;
			
			viewer.look(viewLocal);
		}
		
		public function pyramidView(current:FiSet, deltaIn:FiSet, deltaOut:FiSet):void
		{
//			trace("view===============",this);
			var inList:Vector.<FoldIndex>=deltaIn.getList();
			var outList:Vector.<FoldIndex>=deltaOut.getList();
			var in_:FoldIndex;
			var out_:FoldIndex;
			var up:FoldIndex;
			var tile:ZimageLargeTile;
			
			for each(in_ in inList) {
				tile=pyramid.getTile_(in_.fi) as ZimageLargeTile;
				if(tile.textureType!=ZsheetOp.Empty){
					bsLoading.put(in_);
				}
			}
			
			for each(in_ in inList) {
				tile=pyramid.getTile_(in_.fi) as ZimageLargeTile;
				if(tile.textureType!=ZsheetOp.Empty){
//					trace("in",in_,this);
//					Gallerid.singleton().touch(tile.mc5);
					var zlts:ZimageLargeSprite=new ZimageLargeSprite(host,tile);
					fi_ZimageLargeTileSprite[in_.fi]=zlts;
					zlts.load(onLoaded);
				}
			}
			
			for each(out_ in outList) {
				tile=pyramid.getTile_(out_.fi) as ZimageLargeTile;
				if(tile.textureType!=ZsheetOp.Empty){
//					trace("out",out_,this);
					var out_zts:ZimageLargeSprite=fi_ZimageLargeTileSprite[out_.fi];
					out_zts.dispose();
					
					delete fi_ZimageLargeTileSprite[out_.fi];
					bsLoading.remove(out_);
				}
			}
			
			for each(in_ in inList) {
				tile=pyramid.getTile_(in_.fi) as ZimageLargeTile;
				up=FoldIndex.getUp(in_);
				checkHide(up);
			}
			
			for each(out_ in outList) {
				tile=pyramid.getTile_(out_.fi) as ZimageLargeTile;
				up=FoldIndex.getUp(out_);
				checkHide(up);
			}
			
		}
		
		private function onLoaded(zlts:ZimageLargeSprite):void{
			//			trace("loaded",zlts.tile.fi,this);
			bsLoading.remove(zlts.tile.fi);
			//			trace("loading count="+bsLoading.size,this);
			
			checkHide(zlts.tile.fi);
			var up:FoldIndex=FoldIndex.getUp(zlts.tile.fi);
			checkHide(up);
			
			host.sort();
		}
		
		private function checkHide(fi:FoldIndex):void {
			if(fi==null)
				return;
			
			var zlts:ZimageLargeSprite=fi_ZimageLargeTileSprite[fi.fi];
			if(zlts==null){
				//empty tile has empty parent				
				return;
			}
			
			var hide:Boolean=shouldHide(fi);
			zlts.visible=!hide;
		}
		
		private function shouldHide(fi:FoldIndex):Boolean{
			if(fi.z==z)//======== to check
				return false;
			
			var hide:Boolean = true;
			var low4:Vector.<FoldIndex>= FoldIndex.getLow4(fi);
			for each (var low:FoldIndex in low4) {
				if (bsLoading.contains(low)) {
					hide = false;
					break;
				}
			}
			return hide;
		}
	}
}
