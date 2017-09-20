package azura.banshee.zebra
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	[Bindable]
	public class Zfont implements BytesI
	{
		public var version:int=1608292048;
		//========== basic ============
		public var text:String="";
		public var size:int=24;
		public var color:int=0xff0000;
		
		//========== glow ==========
		public var glowStrength:int=1;
		public var glowColor:int=0xffffff;
		
		public function Zfont()
		{
		}
		
		public function fromBytes(reader:ZintBuffer):void
		{
			version=reader.readInt();
			text=reader.readUTFZ();
			size=reader.readZint();
			color=reader.readInt();
			glowStrength=reader.readZint();
			glowColor=reader.readZint();
		}
		
		public function toBytes():ZintBuffer
		{
			var writer:ZintBuffer=new ZintBuffer();
			writer.writeInt(version);
			writer.writeUTFZ(text);
			writer.writeZint(size);
			writer.writeInt(color);
			writer.writeZint(glowStrength);
			writer.writeZint(glowColor);
			return writer;
		}
	}
}