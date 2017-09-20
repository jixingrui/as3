package azura.karma.def
{
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	public class KarmaDefV implements ZintCodecI
	{
		public var version:int;
		public var fieldList:Vector.<KarmaFieldV>=new Vector.<KarmaFieldV>();
		
		private var space:KarmaSpace;
		
		public function KarmaDefV(space:KarmaSpace)
		{
			this.space=space;
		}
		
		public function generate():Vector.<Bean>{
			var beanList:Vector.<Bean> = new Vector.<Bean>(fieldList.length);
			for (var i:int = 0; i < fieldList.length; i++) {
				var field:KarmaFieldV = fieldList[i];
				var bean:Bean = field.newBean();
				beanList[i]=bean;
			}
			return beanList;
		}
		
//		public function load(zb:ZintBuffer):Vector.<Bean> {
//			var beanList:Vector.<Bean> = generate();
//			for each(var bean:Bean in beanList){
//				bean.readFrom(zb);
//			}
//			return beanList;
//		}
		
		public function update(old:KarmaDefV, inList: Vector.<Bean>):Vector.<Bean> {
			var result:Vector.<Bean> = new Vector.<Bean>(fieldList.length);
			for (var i:int = 0; i < fieldList.length; i++) {
				var field:KarmaFieldV = fieldList[i];
				var idxInOld:int = old.getFieldIdx(field.tid);
				if (idxInOld == -1) {
					result[i] = field.newBean();
				} else {
					result[i] = inList[idxInOld];
				}
			}
			return result;
		}
		
		private function getFieldIdx(tid:int):int {
			for (var i:int = 0; i < fieldList.length; i++) {
				var field:KarmaFieldV = fieldList[i];
				if (field.tid == tid)
					return i;
			}
			return -1;
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			version=reader.readInt();
			var size:int = reader.readZint();
			for (var i:int = 0; i < size; i++) {
				var v:KarmaFieldV = new KarmaFieldV(space);
				v.readFrom(reader);
				fieldList.push(v);
			}
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			throw new Error();
		}
	}
}