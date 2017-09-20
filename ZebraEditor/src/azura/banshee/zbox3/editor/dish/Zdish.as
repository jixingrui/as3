package azura.banshee.zbox3.editor.dish
{
	import azura.banshee.zebra.Zebra3;
	import azura.common.collections.NameI;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	import azura.gallerid4.Gal4;
	import azura.gallerid4.Gal4PackI;
	
	public class Zdish implements NameI, ZintCodecI, Gal4PackI
	{
		private var name_:String;
		public var mc5Zebra:String;
		public var x:int;
		public var y:int;
		public var dist:int=100;
		
		public var host:Zdishes;
		
		public function Zdish(host:Zdishes){
			this.host=host;
		}
		
		public function get scaleD():Number{
			return 100/dist;
		}
		
		public function get name():String
		{
			return name_;
		}
		
		public function set name(value:String):void
		{
			name_=value;
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			name_=reader.readUTFZ();
			mc5Zebra=reader.readUTFZ();
			x=reader.readZint();
			y=reader.readZint();
			dist=reader.readZint();
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			writer.writeUTFZ(name_);
			writer.writeUTFZ(mc5Zebra);
			writer.writeZint(x);
			writer.writeZint(y);
			writer.writeZint(dist);
		}
		
		public function getMc5List(dest:Vector.<String>):void{
			if(mc5Zebra==null || mc5Zebra.length==0)
				return;
			
			var zb:ZintBuffer=Gal4.readSync(mc5Zebra);
			zb.uncompress();
			var zebra:Zebra3=new Zebra3();
			zebra.fromBytes(zb);
			
			dest.push(mc5Zebra);
			zebra.getMc5List(dest);
		}
	}
}