package azura.banshee.zebra
{
	import azura.banshee.zebra.i.ZebraI;
	import azura.banshee.zebra.zimage.ZemptyOp;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Rectangle;
	
	public class Zebra implements ZebraI
	{
		public static const zempty:int=0;
		public static const zimage:int=1;
		public static const zmatrix:int=2;
		//		public static const zcombo:String="zcombo";
		
		public var branch:ZebraI=new Zempty();
		
		// These meta data are not about how the Zebra was created. It's about how it
		// will be used.
		public var x:int,y:int;
		/**
		 * [0~359] 
		 */
		public var angle:int;
		/**
		 * scale% 
		 */
		public var scale:int;
		public var fps:int;
		
		public function eat(pray:Zebra):void{
			x=pray.x;
			y=pray.y;
			angle=pray.angle;
			scale=pray.scale;
			fps=pray.fps;
			branch=pray.branch;
		}
		
		public function clone():Zebra{
			var c:Zebra=new Zebra();
			c.branch=this.branch;
			c.x=this.x;
			c.y=this.y;
			c.angle=this.angle;
			c.scale=this.scale;
			c.fps=this.fps;
			return c;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var type:int=zb.readZint();			
			if(type==zempty){
				branch=new Zempty();
			}else if(type==zimage){
				branch=new Zimage();
				//			}else if(format==zcombo){
				//				branch=new Zcombo();
			}else if(type==zmatrix){
				branch=new Zmatrix();
			}else{
				throw new Error("Zebra: unknown format");
			}
			branch.fromBytes(zb.readBytesZ());
			x=zb.readZint();
			y=zb.readZint();
			angle=zb.readZint();
			scale=zb.readZint();
			fps=zb.readZint();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(type);
			zb.writeBytesZ(branch.toBytes());
			zb.writeZint(x);
			zb.writeZint(y);
			zb.writeZint(angle);
			zb.writeZint(scale);
			zb.writeZint(fps);
			return zb;
		}
		
		public function get type():int{
			if(branch is Zempty)
				return zempty;
			else if(branch is Zimage)
				return zimage;
				//			else if(branch is Zcombo)
				//				return zcombo;
			else if(branch is Zmatrix)
				return zmatrix;
			else
				throw new Error();
		}
		
		public function clear():void
		{
			branch=new Zempty();
		}
		
		public function getMe5List():Vector.<String>
		{
			return branch.getMe5List();
		}
		
		public function get boundingBox():Rectangle{
			return branch.boundingBox;
		}
//		public function get width():int
//		{
//			return branch.width;
//		}
//		
//		public function get height():int
//		{
//			return branch.height;
//		}
	}
}