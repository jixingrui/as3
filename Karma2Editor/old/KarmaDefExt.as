package azura.karma.editor.def
{
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	public class KarmaDefExt implements ZintCodecI
	{
	
		public var core:KarmaDef;
		
		//ext
		public var fieldList:Vector.<KarmaFieldExt>=new Vector.<KarmaFieldExt>();
		
		public function readFrom(zb:ZintBuffer):void
		{	
			
			//============= ext ===============
			var size:int = zb.readZint();
			for (var i:int = 0; i < size; i++) {
//				var idF:int=zb.readInt();
				var kf:KarmaFieldExt=new KarmaFieldExt();
				kf.readFrom(zb);
				fieldList.push(kf);
			}
		}
		
		public function writeTo(zb:ZintBuffer):void
		{

			
			throw new Error();
			
			return zb;
		}
	}
}