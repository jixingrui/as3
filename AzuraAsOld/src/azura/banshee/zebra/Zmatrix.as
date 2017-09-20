package azura.banshee.zebra
{
	import azura.banshee.zebra.i.ZebraI;
	import azura.banshee.zebra.zmotion.Zline;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Rectangle;
	
	public class Zmatrix implements BytesI,ZebraI
	{
		public static const zmatrix:int=0;
		public static const zhline:int=1;
		public static const zvline:int=2;
		
//		public var frameRate:int;
		public var cols:int;
		public var rows:int;
		public var lineList:Vector.<Zline>=new Vector.<Zline>();
//		private var width_:int,height_:int;
		/**
		 * [zmatrix,zhline,zvline]
		 */
//		public var type:String;
		
		public function get type():int{
			if(cols>1&&rows>1)
				return zmatrix;
			else if(rows>1)
				return zvline;
			else
				return zhline;
		}
		
		public function get boundingBox():Rectangle{
			return lineList[0].boundingBox;
		}
		
//		public function get width():int
//		{
//			return lineList[0].width;
//		}
//		
//		public function get height():int
//		{
//			return lineList[0].height;
//		}
		
//		public function get isMotive():Boolean{
//			return type=='zmatrix'||type=='zhline';
//		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
//			type=zb.readUTF();
//			frameRate=zb.readZint();
//			width_=zb.readZint();
//			height_=zb.readZint();
			cols=zb.readZint();
			rows=zb.readZint();
			var lines:int=zb.readZint();
			for(var i:int=0;i<lines;i++){
				var za:Zline=new Zline();
				za.fromBytes(zb.readBytesZ());
				lineList.push(za);
				//				width_+=za.width;
				//				height_+=za.height;
			}
			//			width_/=rowCount;
			//			height_/=rowCount;
			//			width_*=0.5;
			//			height_*=0.5;
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
//			zb.writeUTF(type);
//			zb.writeZint(frameRate);
//			zb.writeZint(width);
			zb.writeZint(cols);
			zb.writeZint(rows);
			zb.writeZint(lineList.length);
			for(var i:int=0;i<lineList.length;i++){
				zb.writeBytesZ(lineList[i].toBytes());
			}
			return zb;
		}
		
		public function getMe5List():Vector.<String>{
			var result:Vector.<String>=new Vector.<String>();
			for each(var line:Zline in lineList){
				for each(var mc5:String in line.getMe5List()){
					result.push(mc5);
				}
			}
			return result;
		}
		
	}
}