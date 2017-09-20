package azura.avalon.maze3.ui.seeker
{
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	public class TreeCar implements ZintCodecI
	{
		public var idCar:int;
		public var parent:int;
		public var childList:Vector.<int>=new Vector.<int>();
		public var data:ZintBuffer;
		
		//expand
		public var passenger:Object;
		
		public function TreeCar()
		{
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			idCar = reader.readZint();
			parent = reader.readZint();
			var size:int = reader.readZint();
			for (var i:int = 0; i < size; i++) {
				childList.push(reader.readZint());
			}
			data = reader.readBytesZ();
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			writer.writeZint(idCar);
			writer.writeZint(parent);
			writer.writeZint(childList.length);
			for each(var child:int in childList) {
				writer.writeZint(child);
			}
			writer.writeBytesZ(data);
		}
	}
}