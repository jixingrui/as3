package azura.banshee.zbox3.zebra.zimage
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.PyramidViewer2;
	import azura.avalon.fi.view.PyramidViewerI;
	import azura.banshee.zbox3.Zbox3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.container.Zbox3ControllerI;
	import azura.banshee.zebra.branch.ZimageLarge2;
	import azura.banshee.zebra.branch.ZimageLarge2Tile;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	import azura.common.collections.RectC;
	
	import flash.utils.Dictionary;
	
	public class ZimageLargeC3 extends Zbox3Container implements Zbox3ControllerI,PyramidViewerI
	{
		private var pyramid:ZimageLarge2;
		private var fi_Tile:Dictionary=new Dictionary();
		
		private var viewer:PyramidViewer2;
		private var loadingSet:FiSet= new FiSet();
		
		public function ZimageLargeC3(parent:Zbox3)
		{
			super(parent);
			zbox.keepSorted=true;
//			zbox.replica.visible=false;
			viewer=new PyramidViewer2(this,false);
		}
		
		override public function notifyChangeScale():void{
//			trace("notify change scale",zbox.scaleGlobal,this);
			updateView();
		}
		
		override public function notifyChangeView():void{
			var viewLocal:RectC=new RectC();
			var scale:Number=zbox.space.scaleView*zbox.scaleGlobal;
			viewLocal.xc=(zbox.space.xView-zbox.xGlobal);
			viewLocal.yc=(zbox.space.yView-zbox.yGlobal);
			viewLocal.width=zbox.space.widthView/scale;
			viewLocal.height=zbox.space.heightView/scale;
			
//			trace("notify change view",viewLocal,this);
			viewLocal.xc/=512;
			viewLocal.yc/=512;
			viewLocal.width/=512;
			viewLocal.height/=512;
			
//			trace("z=",targetZup,"view=",viewLocal,this);
			viewer.look(viewLocal);
		}
		
		public function pyramidView(current:FiSet, deltaIn:FiSet, deltaOut:FiSet):void
		{
//			trace("pyramid current=",current.size,"in=",deltaIn.size,"out=",deltaOut.size,this);
			var inList:Vector.<FoldIndex>=deltaIn.getList();
			var outList:Vector.<FoldIndex>=deltaOut.getList();
			var in_:FoldIndex;
			var out_:FoldIndex;
			var up:FoldIndex;
			var tile:ZimageLarge2Tile;
			
			loadingSet.putAll(deltaIn);
			
			for each(in_ in inList) {
				tile=pyramid.getTile_(in_.fi) as ZimageLarge2Tile;
				var zlts:ZimageLargeTileC3=new ZimageLargeTileC3(this.zbox,this);
				fi_Tile[in_.fi]=zlts;
				zlts.feed(tile);
			}
			
			for each(out_ in outList) {
				tile=pyramid.getTile_(out_.fi) as ZimageLarge2Tile;
				var out_zts:ZimageLargeTileC3=fi_Tile[out_.fi];
				out_zts.zbox.dispose();
				
				delete fi_Tile[out_.fi];
				loadingSet.remove(out_);
			}
			
			for each(in_ in inList) {
				tile=pyramid.getTile_(in_.fi) as ZimageLarge2Tile;
				checkHide(in_);
			}
			
			for each(out_ in outList) {
				tile=pyramid.getTile_(out_.fi) as ZimageLarge2Tile;
				checkHide(out_);
			}
			
		}
		
		internal function notifyTileLoaded(tile:ZimageLarge2Tile):void{
			//			trace("loaded",tile.fi,this);
			loadingSet.remove(tile.fi);
			//			trace("loading count="+loadingSet.size,this);
			
			checkHide(tile.fi);
		}
		
		private function checkHide(fi:FoldIndex):void {
			
			if(fi==null)
				return;
			
			var up:FoldIndex=FoldIndex.getUp(fi);
			
			if(up==null)
				return;
			
			var hide:Boolean=shouldHide(up);
			var ut:ZimageLargeTileC3=fi_Tile[up.fi];
			if(ut==null)
			{
				return;
			}
			
			ut.zbox.visible=!hide;
		}
		
		/**
		 *  Tiles below scale up, showing zig zag.
		 * 
		 */
		private function shouldHide(fi:FoldIndex):Boolean{			
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
			updateView();
		}
		
		private function updateView():void{
			viewer.clear();
			viewer.z=pyramid.zMax-zUp;
//			trace("viewer.z=",viewer.z,"zMax=",pyramid.zMax,this);
			notifyChangeView();
		}
		
		private function get zUp():int{
			var target:int= FastMath.log2(Math.floor(1/(zbox.scaleGlobal*zbox.space.scaleView)));
			target= Math.min(target,pyramid.zMax);
//			trace("zUp",target,this);
			return target;
		}
		
//		override public function notifyReady():void{
//			trace("me ready",this);
//			zbox.replica.visible=true;
//		}
		
//		override public function notify
		
	}
}