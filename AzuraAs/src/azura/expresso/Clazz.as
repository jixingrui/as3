package azura.expresso {
	import azura.expresso.bean.Bean;
	import azura.expresso.field.FieldA;
	import azura.expresso.field.FieldBoolean;
	import azura.expresso.field.FieldBytes;
	import azura.expresso.field.FieldDatum;
	import azura.expresso.field.FieldDouble;
	import azura.expresso.field.FieldInt;
	import azura.expresso.field.FieldList;
	import azura.expresso.field.FieldString;
	
	import flash.utils.Dictionary;
	
	public class Clazz {
		
		public var id:int;
		private var fieldCount:int;
		private var id_Field:Dictionary;
		public var ns:NameSpace;
		public var fieldAll:Vector.<FieldA>=new Vector.<FieldA>();
		
		public function Clazz(ns:NameSpace,id:int) {
			this.ns=ns;
			this.id = id;
		}
		
		public function populateAncestor(ancSet:Vector.<int>):void {
		}
		
		public function populateField(defAll:Vector.<FieldLoader>):void {
//			fieldAll=defAll;
			
			defAll.sort(FieldLoader.compare);
						
			fieldCount=defAll.length;
			id_Field=new Dictionary();
			for(var idx:int=0;idx<fieldCount;idx++){
				var fd:FieldLoader=defAll[idx];
				var field:FieldA= newField(idx, fd.type, fd.isList);
				id_Field[fd.id]=field;
				fieldAll.push(field);
			}
		}
		
		private function newField(idxBean:int, type:int, isList:Boolean):FieldA {
			var f:FieldA= null;
			
			switch (type) {
				case PrimitiveE.Int:
					f = new FieldInt(idxBean);
					break;
				case PrimitiveE.String:
					f = new FieldString(idxBean);
					break;
				case PrimitiveE.Boolean:
					f = new FieldBoolean(idxBean);
					break;
				case PrimitiveE.Bytes:
					f = new FieldBytes(idxBean);
					break;
				case PrimitiveE.Double:
					f = new FieldDouble(idxBean);
					break;
				default:
					f = new FieldDatum(idxBean, ns, type);
					break;
			}
			
			if (isList) {
				f = new FieldList(idxBean, f);
			}
			return f;
		}
		
		public function populateBean(datum:Datum):void {
			datum.beanList = new Vector.<Bean>(fieldCount);
			for(var i:* in id_Field){
				var f:FieldA=id_Field[i];
				datum.beanList[f.idxBean] = f.newBean();
			}
		}
		
		public function fieldToIdxBean(idField:int):int {
			return FieldA(id_Field[idField]).idxBean;
		}
	}
}