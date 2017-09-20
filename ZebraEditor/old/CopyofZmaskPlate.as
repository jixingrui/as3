package azura.banshee.maze.zforest
{
	import azura.avalon.fi.view.FiSet;
	import azura.avalon.fi.view.ViewerI;
	import azura.banshee.zebra.i.ZimageRendererI;
	import azura.banshee.zplate.Zplate;
	import azura.banshee.zplate.ZplateRendererI;
	import azura.banshee.zsheet.Zframe;
	import azura.banshee.zsheet.Ztexture;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.FoldIndex;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import old.azura.banshee.zimage.i.ZrendererI;
	import old.azura.banshee.zimage.plate.ZplateOld;
	import azura.banshee.zmask.PyramidMask;
	import azura.banshee.zmask.TileMask;
	
	public class ZmaskPlate extends Zplate implements ViewerI
	{
//		private var bak:ZintBuffer;
//		private var _data:PyramidMask;
		private var key_Ztexture:Dictionary=new Dictionary();
		
		private var renderer:ZimageRendererI;
		private var _data:PyramidMask;
		
		public function ZmaskPlate(parent:Zplate, renderer:ZimageRendererI)
		{
			super(parent, renderer);
			this.renderer=renderer;
//			_data=new PyramidMask(this);
		}

		public function get data():PyramidMask
		{
			return _data;
		}

		public function set data(value:PyramidMask):void
		{
			_data = value;
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
				tm=_data.getTile_(fi.fi) as TileMask;
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
				tm=_data.getTile_(fi.fi) as TileMask;
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
		
		protected function look_():void{
			
			var vg:Rectangle=viewGlobal;
			//on the current layer
			var box:Rectangle=_data.boundingBox.clone();
			box.x=(box.x+xGlobal)>>zUp;
			box.y=(box.y+yGlobal)>>zUp;
			box.width=box.width>>zUp;
			box.height=box.height>>zUp;
			//			trace();
			//			trace("viewGlobal:  "+view);
			//			trace("boundingBox: "+box);
			
			if(vg.intersects(box)){
				vg.x/=256;
				vg.y/=256;
				vg.width/=256;
				vg.height/=256;
//				trace(vg);
				_data.look(vg);
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
		
//		override protected function set zUp(value:Number):void{
//			clear();
//			if(_data!=null){
//				checkZ();
//				look_();
//			}
////			super.zUp=value;
//		}
		
		private function checkZ():void{
			_data.clear();
			var value:int=zUp;
			_data.z=_data.zMax-value;
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
//			bak=zb.clone();
			_data.fromBytes(zb);
			_data.z=_data.zMax-zUp;
			look_();
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
		
		public function clear():void{
			
		}
	}
}