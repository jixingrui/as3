package azura.karma.editor.def
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	import flash.net.dns.AAAARecord;
	
	public class KarmaDef implements BytesI
	{
		//core
		public var id:int;
		public var versionSelf:int;
		public var note:String;
		
		//hard item
		public var name:String;
		public var idParent:int;
		
		//history
		public var historyData:ZintBuffer;
		
		public function KarmaDef()
		{
		}
		
		public function init():void
		{
			id=0;
			versionSelf=0;
			note="empty";
			name="karmaX";
			idParent=0;
			historyData=null;
		}
		
		public function fromBytes(reader:ZintBuffer):void
		{
			id=reader.readInt();
			versionSelf=reader.readInt();
			note=reader.readUTFZ();
			name=reader.readUTFZ();
			idParent=reader.readInt();
			historyData=reader.readBytesZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var writer:ZintBuffer=new ZintBuffer();
			writer.writeInt(id);
			writer.writeInt(versionSelf);
			writer.writeUTFZ(note);
			writer.writeUTFZ(name);
			writer.writeInt(idParent);
			writer.writeBytesZ(historyData);
			return writer;
		}
	}
}