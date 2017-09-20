package azura.banshee.mass.model
{
	import azura.common.collections.bitset.BitSet;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	public class ScreenSetting implements BytesI
	{
		public var designWidth:int=1280;
		public var designHeight:int=720;
		public var propSet:BitSet=new BitSet();
		
		//calculate
		public var scale:Number=1;
		public var dragWidth:Number;
		public var dragHeight:Number;
		
		public function display(screenWidth:Number,screenHeight:Number):void{
			var designRatio:Number=designWidth/designHeight;
			var screenRatio:Number=screenWidth/screenHeight;
			if(designRatio>=screenRatio){
				//fit width
				scale=screenWidth/designWidth;
				dragWidth=designWidth;
				dragHeight=designWidth/screenRatio;
			}else{
				//fit height
				scale=screenHeight/designHeight;
				dragHeight=designHeight;
				dragWidth=designHeight*screenRatio;
			}
		}
		
		public static function fitScale(fromW:Number,fromH:Number,toW:Number,toH:Number):Number{
			var fromS:Number=fromW/fromH;
			var toS:Number=toW/toH;
			if(fromS>=toS){
				return toW/fromW;
			}else{
				return toH/fromH;
			}
		}
		
		public function fromBytes(reader:ZintBuffer):void
		{
			designWidth = reader.readZint();
			designHeight = reader.readZint();
			propSet.fromBytes(reader.readBytesZ());
		}
		
		public function toBytes():ZintBuffer
		{
			var writer:ZintBuffer=new ZintBuffer();
			writer.writeZint(designWidth);
			writer.writeZint(designHeight);
			writer.writeBytesZ(propSet.toBytes());
			return writer;
		}
	}
}