package old.azura.avalon.ice.swamp
{
	import azura.common.collections.ZintBuffer;

	[Bindable]
	public class Skin
	{
		public var name:String="-";
		public var color:int;
		public var md5N4:String;
		
		public function Skin()
		{
//			md5N4=Monster.defaultPerson;
		}
		
		public function encode():ZintBuffer{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTF(name);
			zb.writeInt(color);
			zb.writeUTF(md5N4);
			zb.position=0;
			return zb;
		}
		
		public function decode(zb:ZintBuffer):void{
			name=zb.readUTF();
			color=zb.readInt();
			md5N4=zb.readUTF();
		}
	}
}