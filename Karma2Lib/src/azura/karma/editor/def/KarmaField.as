package azura.karma.editor.def {
	
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	
	public class KarmaField implements ZintCodecI {
		
		public var id:int;		
		public var type:int;		
		public var note:String = "empty";
		
		//hard item
		public var name:String;
		
		public function init():void{
			id=0;
			type=8;
			note="empty";
			name="";
		}
		
		public function readFrom(reader:ZintBuffer):void {
			id = reader.readInt();
			type = reader.readZint();
			note = reader.readUTFZ();
			name=reader.readUTFZ();
		}
		
		public function writeTo(writer:ZintBuffer):void {
			writer.writeInt(id);
			writer.writeZint(type);
			writer.writeUTFZ(note);
			writer.writeUTFZ(name);
		}
	}
	
	
}