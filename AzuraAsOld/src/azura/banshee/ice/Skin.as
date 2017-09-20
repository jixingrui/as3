package azura.banshee.ice
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	public class Skin implements BytesI
	{
		public var name:String;
		public var mc5:String;
		public var uid:String;
		
		public function Skin()
		{
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			if(zb.length==0)
				return;
			
			zb.position=0;
			name=zb.readUTF();
			mc5=zb.readUTF();
			uid=zb.readUTF();
			zb.position=0;
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTF(name);
			zb.writeUTF(mc5);
			zb.writeUTF(uid);
			return zb;
		}
		
		public function toString():String{
			return name+" "+uid;
		}
		
		public function clone():Skin{
			var c:Skin=new Skin();
			c.name=name;
			c.mc5=mc5;
			c.uid=uid;
			return c;
		}
	}
}