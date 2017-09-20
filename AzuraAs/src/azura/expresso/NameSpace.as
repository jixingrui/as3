package azura.expresso {
	import azura.expresso.field.FieldList;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	public class NameSpace {
		
		private var id_Class:Dictionary;
		
		public function newDatum(idClass:int):Datum {
			var clazz:Clazz= getClass(idClass);
			var datum:Datum= new Datum(clazz);
			clazz.populateBean(datum);
			return datum;
		}
		
		public function getClass(idClass:int):Clazz {
			var clazz:Clazz= id_Class[idClass];
			if (clazz == null)
				throw new IllegalOperationError("Expresso class not found");
			return clazz;
		}
		
		private function populateClass(classDefAll:Vector.<int>):void {
			id_Class = new Dictionary();
			for each(var id:int in classDefAll) {
				var c:Clazz= new Clazz(this,id);
				id_Class[id]=c;
			}
		}
		
		public function NameSpace(classStore:Array):void {
			
			var classDef:Array;
			var idClass:int;
			var clazz:Clazz;
			
			// class def
			var classDefAll:Vector.<int> =new Vector.<int>();
			for each(classDef in classStore) {
				idClass= classDef[0][0];
				classDefAll.push(idClass);
			}
			populateClass(classDefAll);
			
			// family
			var family:Family= new Family();
			for each(classDef in classStore) {
				idClass= classDef[0][0];
				var parents:Array= classDef[1];
				for (var j:int= 0; j < parents.length; j++)
					family.link(parents[j], idClass);
			}
			
			// ancestor
			for each(classDef in classStore) {
				idClass= classDef[0][0];
				clazz= getClass(idClass);
				clazz.populateAncestor(family.getAncestorAndSelf(idClass));
			}
			
			// field prepare
			var class_FieldAll:Dictionary=new Dictionary();
			for each(classDef in classStore) {
				idClass= classDef[0][0];
				var fieldList:Vector.<FieldLoader>=new Vector.<FieldLoader>();
				class_FieldAll[idClass]=fieldList;
				
				for (var i:int= 2; i < classDef.length; i++) {
					var fieldDef:Array= classDef[i];
					
					var field:FieldLoader= new FieldLoader();
					field.id = fieldDef[0];
					field.type = fieldDef[1];
					var isListValue:int= fieldDef[2];
					field.isList = (isListValue == 0) ? false : true;
					fieldList.push(field);
				}				
			}
			
			// field
			for(var key:* in class_FieldAll){
				clazz= getClass(key); 
				var fieldDefAll:Vector.<FieldLoader>=new Vector.<FieldLoader>();
//				var fdLocal:Vector.<FieldLoader>=class_FieldAll[key] as Vector.<FieldLoader>;
//				fieldDefAll=fieldDefAll.concat(fdLocal);

				var ancSet:Vector.<int>=family.getAncestorAndSelf(key);
				for each(var anc:int in ancSet){
					var fdLocal:Vector.<FieldLoader>=class_FieldAll[anc] as Vector.<FieldLoader>;
					fieldDefAll=fieldDefAll.concat(fdLocal);
				}
				
				clazz.populateField(fieldDefAll);
			}
		}
	}
}
