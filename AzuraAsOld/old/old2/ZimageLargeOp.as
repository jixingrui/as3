package azura.banshee.zebra.zimage.large
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.PyramidViewer;
	import azura.avalon.fi.view.PyramidViewerI;
	import azura.banshee.zebra.i.ZimageOpI;
	import azura.banshee.zebra.zimage.ZimageOp;
	import azura.banshee.zsheet.Ztexture;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class ZimageLargeOp implements ZimageOpI,PyramidViewerI
	{
		//		private var bsCurrent:FiSet= new FiSet();
		private var fi_Ztexture:Dictionary=new Dictionary();
		private var bsLoaded:FiSet= new FiSet();
		private var bsDisplayed:FiSet= new FiSet();
		
		private var _zUp:int;
		
		private var zimage:ZimageOp;
		
		private var viewer:PyramidViewer;
		
		public function ZimageLargeOp(zimage:ZimageOp)
		{
			this.zimage=zimage;
			viewer=new PyramidViewer(zimage.data.pyramid,this,false);
		}
		
		private function get pyramid():PyramidZimage{
			return zimage.data.pyramid;
		}
		
		public function get zUp():int
		{
			return _zUp;
		}
		
		public function set zUp(value:int):void
		{
			_zUp = value;
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
			return pyramid.zMax-zUp;
		}
		
		public function look(viewLocal:Rectangle):void {
			viewLocal=viewLocal.clone();
			
			viewLocal.x/=256;
			viewLocal.y/=256;
			viewLocal.width/=256;
			viewLocal.height/=256;
			
			viewer.look(viewLocal);
		}
		
		public function visual(current:FiSet, deltaIn:FiSet, deltaOut:FiSet):void
		{
			//			this.bsCurrent=current.clone();
			
			//			for each(var fiShow:FoldIndex in deltaIn.getList()) {
			//				showUp(fiShow);
			//			}
			//do not merge with the loop above
			for each(var in_:FoldIndex in deltaIn.getList()) {
				load(in_);
			}
			
			for each(var out:FoldIndex in deltaOut.getList()) {
				bsDisplayed.remove(out);
				bsLoaded.remove(out);
				var neg:Ztexture=fi_Ztexture[out.fi];
				if(neg.textureType!=Ztexture.Empty){
					if(neg.onDisplay)
						zimage.renderer.undisplay(neg);
					
					if(bsLoaded.contains(out))
						zimage.renderer.unload(neg);
					else
						zimage.renderer.cancel(neg);
				}
				delete fi_Ztexture[out.fi];
			}
		}
		
		
		private function load(fi:FoldIndex):void{
			var tile:TileZimage=pyramid.getTile_(fi.fi) as TileZimage;
			var piece:Ztexture=new Ztexture();
			fi_Ztexture[fi.fi]=piece;
			piece.textureType=tile.textureType;
			
			if(tile.textureType==Ztexture.Empty){
				pieceReady(piece);
				return;
			}
			
			piece.mc5=tile.mc5;
			piece.id=fi.fi;
			piece.depth=fi.z;
			piece.subTexture=false;
			
			var dz:int=z-fi.z;
			var scale:int=FastMath.pow2(dz);
			piece.scale=scale;
			var halfBound:Number=FastMath.pow2(z)/2;
			piece.drift.x=(fi.x<<dz)*256-halfBound*256;
			piece.drift.y=(fi.y<<dz)*256-halfBound*256;
			
			//128 is texture center
			piece.drift.x+=128*scale;
			piece.drift.y+=128*scale;
			
			piece.onReady.addOnce(pieceReady);
			zimage.renderer.load(piece);
		}
		
		private function pieceReady(piece:Ztexture):void{
			var fi:FoldIndex=new FoldIndex(piece.id);
			if(bsLoaded.contains(fi))
				throw new Error("piece ready twice");
			bsLoaded.put(fi);
			
//			piece.onDisplay=true;
//			zimage.renderer.display(piece);
			
			checkHide(fi);
//			if (fi.z < z){
//				checkHide(fi);
//			}
//			var up:FoldIndex= FoldIndex.getUp(fi);
//			if (up !=null && !bsHiding.contains(up)&&bsReady.contains(up))
//				checkHide(up);
		}
		
		private function checkHide(fi:FoldIndex):void {
			var low4:Vector.<FoldIndex>= FoldIndex.getLow4(fi);
			var hide:Boolean= true;
			for each (var low:FoldIndex in low4) {
				//if any low is in visual and not ready
				if (fi_Ztexture[low.fi]!=null && !bsLoaded.contains(low)) {
					hide = false;
					break;
				}
			}
			if (hide) {
				bsDisplayed.put(fi);
				zimage.renderer.hide(fi_Ztexture[fi.fi]);
				var up:FoldIndex= FoldIndex.getUp(fi);
				if (up !=null&&!bsDisplayed.contains(up)&&bsLoaded.contains(up))
					checkHide(up);
			}
		}
		
		public function clear():void{
			pyramid.clear();
//			fi_Ztexture=new Dictionary();
//			bsReady=new FiSet();
//			bsHide=new FiSet();
		}
		
		//		private function showUp(fi:FoldIndex):void {
		//			var up:FoldIndex= FoldIndex.getUp(fi);
		//			if (up ==null)
		//				return;
		//			
		//			if (bsHide.contains(up)) {
		//				bsHide.remove(up);
		//				zimage.renderer.unhide(fi_Ztexture[up.fi]);
		//			} else {
		//				showUp(up);
		//			}
		//		}
	}
}