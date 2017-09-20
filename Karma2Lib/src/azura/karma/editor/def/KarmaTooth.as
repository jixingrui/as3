package azura.karma.editor.def {
	
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	
	public class KarmaTooth implements ZintCodecI {
		
		public var target:int;
		public var note:String = "empty";
		
		public function init():void{
			target=0;
			note="empty";
		}
		
		public function readFrom(reader:ZintBuffer):void {
			target = reader.readInt();
			note = reader.readUTFZ();
		}
		
		public function writeTo(writer:ZintBuffer):void {
			writer.writeInt(target);
			writer.writeUTFZ(note);
		}
		
		public function toBytes():ZintBuffer {
			var zb:ZintBuffer = new ZintBuffer();
			writeTo(zb);
			return zb;
		}
	}
	
	
}