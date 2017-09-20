package azura.banshee.zimage
{
	import azura.banshee.zimage.i.ZimageOpI;
	import azura.banshee.zimage.i.ZimageRendererI;
	import azura.banshee.zsheet.Zframe;
	import azura.banshee.zsheet.Zsheet;
	import azura.banshee.zsheet.Ztexture;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.util.OS;
	
	import flash.geom.Rectangle;
	
	public class ZimageTinyOp implements ZimageOpI, BytesI
	{
//		private var zi:ZimagePlate;
		private var renderer:ZimageRendererI;
		
		private var _zUp:int;
		private var activePiece:Ztexture;
		
		private var sheet:Zsheet=new Zsheet();
		
		public function ZimageTinyOp(renderer:ZimageRendererI)
		{
//			this.zi=zi;
			this.renderer=renderer;
		}
		
		public function get layerCount():int{
			return sheet.frameCount;
		}
		
		public function get zUp():int
		{
			return _zUp;
		}
		
		public function set zUp(value:int):void
		{
			_zUp = value;
		}
		
		public function look(viewLocal:Rectangle):void {
			if(activePiece!=null||zUp<0||sheet==null||sheet.frameCount==0)
				return;
			
			var zf:Zframe=sheet.frames[zUp];
			
			activePiece=new Ztexture();
			activePiece.id=zUp;
			activePiece.depth=zUp;
			activePiece.subTexture=true;
			activePiece.rectOnTexture=zf.rectOnSheet.clone();
			activePiece.md5=sheet.md5;
			
			activePiece.onReady.addOnce(pieceReady);
			renderer.load(activePiece);
		}
		
		public function pieceReady(piece:Ztexture):void{
			if(activePiece==piece){
				piece.onDisplay=true;
				renderer.display(piece);
			}
			else
				renderer.unload(piece);
		}
		
		public function clear():void{
			if(activePiece!=null){
				if(activePiece.onDisplay){
					activePiece.onDisplay=false;
					renderer.undisplay(activePiece);
				}
				renderer.unload(activePiece);
				activePiece=null;
				sheet=new Zsheet();
//				sheet.clear();
			}
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			sheet.fromBytes(zb);
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
	}
}