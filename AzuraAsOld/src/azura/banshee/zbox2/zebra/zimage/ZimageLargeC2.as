package azura.banshee.zbox2.zebra.zimage
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.PyramidViewer2;
	import azura.avalon.fi.view.PyramidViewerI;
	import azura.banshee.zbox2.Zbox2;
	import azura.banshee.zbox2.Zbox2Container;
	import azura.banshee.zbox2.Zbox2ControllerI;
	import azura.banshee.zebra.branch.ZimageLarge2;
	import azura.banshee.zebra.branch.ZimageLarge2Tile;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	import azura.common.collections.RectC;
	
	import flash.utils.Dictionary;
	
	public class ZimageLargeC2 extends Zbox2Container implements Zbox2ControllerI,PyramidViewerI
	{
		private var pyramid:ZimageLarge2;
		private var fi_Tile:Dictionary=new Dictionary();
		
		private var viewer:PyramidViewer2;
		private var loadingSet:FiSet= new FiSet();
		
		public function ZimageLargeC2(parent:Zbox2)
		{
			super(parent,true);
			zbox.keepSorted=true;
			viewer=new PyramidViewer2(this,false);
			zbox.visible=true;
		}
		
		override public function notifyChangeScale():void{
			if(zbox.loadingZup!=targetZup){
				trace("zUp changed",this);				
				update();
			}
		}
		
		override public function notifyChangeView():void{
			var viewLocal:RectC=zbox.screenOnBox;
			
//			trace("view local",viewLocal,this);
			
			var scale:Number=FastMath.pow2x(zbox.zUpGlobal);
			
			viewLocal.xc/=512*scale;
			viewLocal.yc/=512*scale;
			viewLocal.width/=512*scale;
			viewLocal.height/=512*scale;
			
			viewer.look(viewLocal);
		}
		
		public function pyramidView(current:FiSet, deltaIn:FiSet, deltaOut:FiSet):void
		{
			//			trace("in visual",deltaIn.size,this);
			var inList:Vector.<FoldIndex>=deltaIn.getList();
			var outList:Vector.<FoldIndex>=deltaOut.getList();
			var in_:FoldIndex;
			var out_:FoldIndex;
			var up:FoldIndex;
			var tile:ZimageLarge2Tile;
			
			loadingSet.putAll(deltaIn);
			
			for each(in_ in inList) {
				tile=pyramid.getTile_(in_.fi) as ZimageLarge2Tile;
				var zlts:ZimageLargeTileC2=new ZimageLargeTileC2(this.zbox,this);
				fi_Tile[in_.fi]=zlts;
				zlts.feed(tile);
			}
			
			for each(out_ in outList) {
				tile=pyramid.getTile_(out_.fi) as ZimageLarge2Tile;
				var out_zts:ZimageLargeTileC2=fi_Tile[out_.fi];
				out_zts.zbox.dispose();
				
				delete fi_Tile[out_.fi];
				loadingSet.remove(out_);
			}
			
			for each(in_ in inList) {
				tile=pyramid.getTile_(in_.fi) as ZimageLarge2Tile;
				//				up=FoldIndex.getUp(in_);
				checkHide(in_);
			}
			
			for each(out_ in outList) {
				tile=pyramid.getTile_(out_.fi) as ZimageLarge2Tile;
				//				up=FoldIndex.getUp(out_);
				checkHide(out_);
			}
			
		}
		
		internal function notifyTileLoaded(tile:ZimageLarge2Tile):void{
			//			trace("loaded",tile.fi,this);
			loadingSet.remove(tile.fi);
			//			trace("loading count="+loadingSet.size,this);
			
			checkHide(tile.fi);
			//			var up:FoldIndex=FoldIndex.getUp(tile.fi);
			//			checkHide(tile.fi);
			
			//			host.sort();
		}
		
		//		internal function checkHideUp(tile:ZimageLarge2Tile):void{
		//			up=FoldIndex.getUp(out_);
		//			checkHide(up);
		//		}
		
		private function checkHide(fi:FoldIndex):void {
			//			trace("check hide",fi,this);
			
			if(fi==null)
				return;
			
			var up:FoldIndex=FoldIndex.getUp(fi);
			
			if(up==null)
				return;
			
			//			if(tile==null){
			//				//empty tile has empty parent				
			//				return;
			//			}
			
			var hide:Boolean=shouldHide(up);
			//			if(hide)
			//				trace("hide",up,this);
			var ut:ZimageLargeTileC2=fi_Tile[up.fi];
			if(ut==null)
			{
//				trace("nothing",this);
				return;
			}
			ut.zbox.visible=!hide;
		}
		
		/**
		 *  Tiles below scale up, showing zig zag.
		 * 
		 */
		private function shouldHide(fi:FoldIndex):Boolean{
			//			if(fi.z==zbox.zUpGlobal)//======== to check
			//				return false;
			
			var allCovered:Boolean = true;
			var low4:Vector.<FoldIndex>= FoldIndex.getLow4(fi);
			for each (var low:FoldIndex in low4) {
				if (loadingSet.contains(low)) {
					allCovered = false;
					break;
				}
			}
			return allCovered;
		}
		
		public function feed(data:ZimageLarge2):void{
			this.pyramid=data;
			//			zbox.loadingZup=pyramid.zMax+1;
			update();
		}
		
		private function update():void{
			viewer.clear();
			viewer.z=pyramid.zMax-targetZup;
			zbox.loadingZup=zbox.zUpGlobal;
			notifyChangeView();
		}
		
		private function get targetZup():int{
			return Math.min(zbox.zUpGlobal,pyramid.zMax);
		}
		
		override public function notifyDispose():void{
//			trace("notify dispose",this);
		}
		
	}
}