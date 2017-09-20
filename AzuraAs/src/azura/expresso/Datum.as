package azura.expresso {
	
	import azura.expresso.bean.Bean;
	
	import azura.common.collections.ZintBuffer;
	
	public class Datum {
		public var clazz:Clazz;
		public var beanList:Vector.<Bean>;
		
		public function Datum(clazz:Clazz) {
			this.clazz = clazz;
		}
		
		public function getBean(idField:int):Bean {
			var idx:int= clazz.fieldToIdxBean(idField);
			return beanList[idx];
		}
		
		public function readFrom(source:ZintBuffer):void {
			for each (var b:Bean in beanList) {
				b.readFrom(source);
			}
		}
			
		public function writeTo(dest:ZintBuffer):void {
			for each (var b:Bean in beanList) {
				b.writeTo(dest);
			}
		}
		
		public function toBytes():ZintBuffer{
			var zb:ZintBuffer=new ZintBuffer();
			writeTo(zb);
			zb.position=0;
			return zb;
		}
		
		public function CLASSID():int {
			return clazz.id;
		}
		
		public function applyDelta(delta:Delta):void{
			delta.apply(this);
		}
	}
}