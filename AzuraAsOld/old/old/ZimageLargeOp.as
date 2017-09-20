package azura.banshee.zimage
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.ViewerI;
	import azura.avalon.ice.old.dish.TextureType;
	import azura.avalon.ice.old.land.PyramidLand;
	import azura.avalon.ice.old.land.TileLand;
	import azura.banshee.zimage.i.ZimageOpI;
	import azura.banshee.zimage.i.ZimageRendererI;
	import azura.banshee.zsheet.Ztexture;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class ZimageLargeOp implements ZimageOpI,BytesI,ViewerI
	{
		private var bsTarget:FiSet= new FiSet();
		private var bsReady:FiSet= new FiSet();
		private var bsHide:FiSet= new FiSet();
		
		private var fi_Ztexture:Dictionary=new Dictionary();
		
		private var pyramid:PyramidLand;
		
//		private var zi:ZimagePlate;
		
		private var renderer:ZimageRendererI;
		
		private var _z:int;
		
		public function ZimageLargeOp(renderer:ZimageRendererI)
		{
			this.renderer=renderer;
			pyramid=new PyramidLand(this);
		}
		
		public function get zUp():int
		{
			return _z;
		}
		
		public function set zUp(value:int):void
		{
			_z = value;
			pyramid.z=z;
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
			viewLocal.x/=256;
			viewLocal.y/=256;
			viewLocal.width/=256;
			viewLocal.height/=256;
			
			pyramid.look(viewLocal);
		}
		public function visual(targets:FiSet, deltaIn:FiSet, deltaOut:FiSet):void
		{
			this.bsTarget=targets;
			
			var fi:FoldIndex;
			for each(fi in deltaIn.dict) {
				showUp(fi);
				
				loadTex(fi);
			}
			for each(var out:FoldIndex in deltaOut.dict) {
				bsHide.remove(out);
				bsReady.remove(out);
				var neg:Ztexture=fi_Ztexture[out.fi];
				if(neg.textureType!=TextureType.Empty){
					if(neg.onDisplay)
						renderer.undisplay(neg);
					renderer.unload(neg);
				}
				delete fi_Ztexture[out.fi];
			}
		}
				
		private function loadTex(fi:FoldIndex):void{
			var tile:TileLand=pyramid.getTile_(fi.fi) as TileLand;
			var piece:Ztexture=new Ztexture();
			fi_Ztexture[fi.fi]=piece;
			piece.md5=tile.md5;
			piece.id=fi.fi;
			piece.depth=fi.fi;
			piece.subTexture=false;
			piece.textureType=tile.plateType;
			
			if(piece.textureType!=TextureType.Empty){
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
				renderer.load(piece);
			}
		}
		
		private function pieceReady(piece:Ztexture):void{
			piece.onDisplay=true;
			renderer.display(piece);
//			zi.childMoved=true;
			renderer.sortChildren();
			
			var fi:FoldIndex=new FoldIndex(piece.id);
			if (bsTarget.contains(fi) == false)
				return;
			
			bsReady.put(fi);
			if (fi.z < z)
				checkHide(fi);
			else{
				var up:FoldIndex= FoldIndex.getUp(fi);
				if (up !=null && !bsHide.contains(up)&&bsReady.contains(up))
					checkHide(up);
			}
		}
		
		private function checkHide(fi:FoldIndex):void {
			var low4:Vector.<FoldIndex>= FoldIndex.getLow4(fi);
			var suc:Boolean= true;
			for each (var low:FoldIndex in low4) {
				if (bsTarget.contains(low) && !bsReady.contains(low)) {
					suc = false;
					break;
				}
			}
			if (suc) {
				bsHide.put(fi);
				renderer.hide(fi_Ztexture[fi.fi]);
				var up:FoldIndex= FoldIndex.getUp(fi);
				if (up !=null&&!bsHide.contains(up)&&bsReady.contains(up))
					checkHide(up);
			}
		}
		
		private function showUp(fi:FoldIndex):void {
			var up:FoldIndex= FoldIndex.getUp(fi);
			if (up ==null)
				return;
			
			if (bsHide.contains(up)) {
				bsHide.remove(up);
				renderer.unhide(fi_Ztexture[up.fi]);
			} else {
				showUp(up);
			}
		}
		
		public function clear():void{
			pyramid.clear();
			fi_Ztexture=new Dictionary();
			bsTarget=new FiSet();
			bsReady=new FiSet();
			bsHide=new FiSet();
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			pyramid.fromBytes(zb);
			pyramid.z=z;
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
	}
}