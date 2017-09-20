package azura.banshee.zimage
{
	import azura.banshee.zimage.i.ZimageOpI;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ByteSerializable;
	import azura.common.collections.ZintBuffer;
	import azura.common.util.OS;
	
	import flash.geom.Rectangle;
	
	public class ZimageTiny implements ZimageOpI, ByteSerializable
	{
		private var zi:Zimage;
		private var _z:int;
		private var md5_3:Vector.<String>=new Vector.<String>(3);
		private var activePiece:ZimagePiece;
		
		public function ZimageTiny(zp:Zimage)
		{
			this.zi=zp;
		}
		
		public function get z():int
		{
			return _z;
		}

		public function set z(value:int):void
		{
			_z = value;
		}

		public function pieceReady(piece:ZimagePiece):void{
		}
		
		public function look(viewLocal:Rectangle):void {
			if(activePiece!=null||z<0)
				return;
			if(z>7)
				throw new Error("ZimageTiny: z cannot exceed 7");
			
			activePiece=new ZimagePiece();
			activePiece.id=zi.z-8;
			activePiece.rectOnTexture.x=FastMath.pow2(zi.z);
			activePiece.rectOnTexture.y=0;
			activePiece.rectOnTexture.width=FastMath.pow2(zi.z);
			activePiece.rectOnTexture.height=FastMath.pow2(zi.z);
			activePiece.manager=this;
			if(OS.isPc)
				activePiece.md5=md5_3[0];
			else if(OS.isAndroid)
				activePiece.md5=md5_3[1];
			else
				activePiece.md5=md5_3[2];
			
			zi.imageRenderer.load(activePiece);
		}
		
		public function clear():void{
			if(activePiece!=null)
				zi.imageRenderer.unload(activePiece);
			activePiece=null;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var zMax:int=zb.readZint();
			md5_3[0]=zb.readUTF();
			md5_3[1]=zb.readUTF();
			md5_3[2]=zb.readUTF();
		}
		
		public function toBytes():ZintBuffer
		{
			return null;
		}
	}
}