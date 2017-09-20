package old.azura.banshee.zimage
{
	import old.azura.banshee.zimage.i.ZrendererI;
	import old.azura.banshee.zimage.plate.ZplateOld;
	import azura.banshee.zsheet.Zframe;
	import azura.banshee.zsheet.Zsheet;
	import azura.banshee.zsheet.Ztexture;
	import azura.common.algorithm.mover.FramerI;
	import azura.common.algorithm.mover.PlayerOld;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.util.OS;
	
	import flash.geom.Rectangle;
	
	public class ZlineOld extends ZplateOld implements BytesI,FramerI{
		
		private var _frameCount:int;
		private var layers:Vector.<Zsheet>=new Vector.<Zsheet>();
		public var boundingBox:Rectangle=new Rectangle();
		private var currentLayer:Zsheet;
		private var currentPiece:Ztexture;
		
		private var player:PlayerOld;
		private var inVisual:Boolean;
		
		public function ZlineOld(parent:ZplateOld, renderer:ZrendererI)
		{
			super(parent, renderer);
			player=new PlayerOld();
		}
		
		public function get imageRenderer():ZrendererI{
			return super.renderer as ZrendererI;
		}
		
		public function get frameCount():int
		{
			return _frameCount;
		}
		
		public function showFrame(frame:int):void
		{
			clear();
			
			var zf:Zframe=currentLayer.frames[frame];
			
			currentPiece=new Ztexture();
			currentPiece.id=frame;
			currentPiece.depth=0;
			currentPiece.subTexture=true;
			currentPiece.rectOnTexture=zf.rectOnSheet.clone();
			currentPiece.drift.x=zf.rectOnSheet.width/2-zf.anchor.x;
			currentPiece.drift.y=zf.rectOnSheet.height/2-zf.anchor.y;
			currentPiece.mc5=currentLayer.mc5;
			
			currentPiece.onReady.addOnce(pieceReady);
			imageRenderer.load(currentPiece);
		}
		
		private function pieceReady(piece:Ztexture):void{
			piece.onDisplay=true;
			imageRenderer.display(piece);
		}
		
		override protected function set zUpInternal(value:Number):void{
			clear();
			checkZ();
			super.zUpInternal=value;
		}
		
		public function clear():void{
			if(currentPiece!=null){
				if(currentPiece.onDisplay)
					imageRenderer.undisplay(currentPiece);
				imageRenderer.unload(currentPiece);
				currentPiece=null;
			}
		}
		
		private function checkZ():void{
			var value:int=zUpInternal;
			if(value<layers.length){
				currentLayer=layers[value];
				player.resume();
			}else{
				player.pause();
				currentLayer=null;
			}
		}
		
		override protected function look_():void{
			
			var vg:Rectangle=viewGlobal;
			//on the current layer
			var box:Rectangle=boundingBox.clone();
			box.x=(box.x+xGlobal)>>zUpInternal;
			box.y=(box.y+yGlobal)>>zUpInternal;
			box.width=box.width>>zUpInternal;
			box.height=box.height>>zUpInternal;
			//			trace();
			//			trace("viewGlobal:  "+view);
			//			trace("boundingBox: "+box);
			
			if(vg.intersects(box)){
				inVisual=true;
				//				player.play(true,true);
				player.resume();
				//				zi.imageRenderer.load(currentPiece);
			}else{
				inVisual=false;
				player.pause();
			}
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{		
			var zanime:String=zb.readUTF();
			boundingBox.x=zb.readZint();
			boundingBox.y=zb.readZint();
			boundingBox.width=zb.readZint();
			boundingBox.height=zb.readZint();
			_frameCount=zb.readZint();
			var layerCount:int=zb.readZint();
			layers=new Vector.<Zsheet>(layerCount);
			
			for(var i:int=0;i<layerCount;i++){
				var layer:Zsheet=new Zsheet();
				layer.fromBytes(zb.readBytes_());
				layers[i]=layer;
			}
			checkZ();
			look_();
			if(inVisual)
				player.play(true,true);
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
		
		//		public function get frameCount():int
		//		{
		//			return 0;
		//		}
		
	}
}