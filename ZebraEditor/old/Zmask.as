package azura.banshee.zmask
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.ViewerI;
	import azura.banshee.zebra.i.ZimageRendererI;
	import azura.banshee.zplate.Zplate;
	import azura.banshee.zsheet.Zframe;
	import azura.banshee.zsheet.Ztexture;
	import azura.common.algorithm.FoldIndex;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import old.azura.banshee.zimage.i.ZrendererI;
	import old.azura.banshee.zimage.plate.ZplateOld;
	
	public class Zmask extends Zplate implements BytesI,ViewerI
	{
		private var bak:ZintBuffer;
		private var pyramid:PyramidMask;
		private var key_Ztexture:Dictionary=new Dictionary();
		public var renderer:ZimageRendererI;
		
		public function Zmask(parent:Zplate, renderer:ZrendererI)
		{
			super(parent, renderer);
			this.renderer=renderer;
			pyramid=new PyramidMask(this);
		}
		public function visual(targets:FiSet, deltaIn:FiSet, deltaOut:FiSet):void
		{
			var fi:FoldIndex;
			var tm:TileMask;
			var i:int;
			var pos:Point;
			var frame:Zframe;
			var zt:Ztexture;
			var key:String;
			for each(fi in deltaIn.getList()){
				tm=pyramid.getTile_(fi.fi) as TileMask;
				for(i=0;i<tm.sheet.frameCount;i++){
					pos=tm.shardPosList[i];
					frame=tm.sheet.frames[i];
					
					zt=new Ztexture();
					key=makeKey(tm,i);
					key_Ztexture[key]=zt;
					zt.id=i;
					zt.depth=pos.y;
					zt.subTexture=true;
					zt.rectOnTexture=frame.rectOnSheet.clone();
					//					var half:int=FastMath.pow2(fi.z)*128;
					zt.drift.x=pos.x+frame.rectOnSheet.width/2-frame.anchor.x;
					zt.drift.y=pos.y+frame.rectOnSheet.height/2-frame.anchor.y;
					//					zt.drift.x=half-fi.x*256+frame.rectOnSheet.width/2-frame.centerOnImage.x;
					//					zt.drift.y=half-fi.y*256+frame.rectOnSheet.height/2-frame.centerOnImage.y;
					zt.md5=tm.sheet.md5;
					
					zt.onReady.addOnce(texReady);
					renderer.load(zt);
				}
			}
			for each(fi in deltaOut.getList()){
				tm=pyramid.getTile_(fi.fi) as TileMask;
				for(i=0;i<tm.sheet.frameCount;i++){
					pos=tm.shardPosList[i];
					frame=tm.sheet.frames[i];
					
					key=makeKey(tm,i);
					zt=key_Ztexture[key] as Ztexture;
					if(zt.onDisplay)
						renderer.undisplay(zt);
					renderer.unload(zt);
				}				
			}
		}
		private function texReady(tex:Ztexture):void{
			tex.onDisplay=true;
			renderer.display(tex);
//			renderer.sortChildren();
			//			super.childMoved=true;
		}
		private function makeKey(tm:TileMask,idxFrame:int):String{
			return tm.fi.fi+"_"+idxFrame;
		}
		
		override protected function look_():void{
			
			var vg:Rectangle=viewGlobal;
			//on the current layer
			var box:Rectangle=pyramid.boundingBox.clone();
			box.x=(box.x+xGlobal)>>zUpInternal;
			box.y=(box.y+yGlobal)>>zUpInternal;
			box.width=box.width>>zUpInternal;
			box.height=box.height>>zUpInternal;
			//			trace();
			//			trace("viewGlobal:  "+view);
			//			trace("boundingBox: "+box);
			
			if(vg.intersects(box)){
				vg.x/=256;
				vg.y/=256;
				vg.width/=256;
				vg.height/=256;
				//				trace(vg);
				pyramid.look(vg);
				//				trace("in visual");
				//				inVisual=true;
				//				player.play(true,true);
				//				player.resume();
				//				zi.imageRenderer.load(currentPiece);
			}else{
				//				inVisual=false;
				//				player.stop();
			}
		}
		
		override protected function set zUpInternal(value:Number):void{
			clear();
			if(pyramid!=null){
				checkZ();
				look_();
			}
			super.zUp=value;
		}
		
		private function checkZ():void{
			pyramid.clear();
			var value:int=zUpInternal;
			pyramid.z=pyramid.zMax-value;
			//			if(value<layers.length){
			//				currentLayer=layers[value];
			//				player.resume();
			//			}else{
			//				player.stop();
			//				currentLayer=null;
			//			}
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			bak=zb.clone();
			pyramid.fromBytes(zb);
			pyramid.z=pyramid.zMax-zUpInternal;
			look_();
		}
		
		public function toBytes():ZintBuffer
		{
			return bak;
		}
		
		public function clear():void{
			
		}
	}
}