package azura.karma.run {
	
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.karma.def.Bean;
	import azura.karma.def.KarmaDefV;
	import azura.karma.def.KarmaHistory;
	import azura.karma.def.KarmaNow;
	import azura.karma.def.KarmaSpace;
	import azura.karma.run.bean.KarmaList;
	
	
	public class Karma implements BytesI {
		
		private var type_:int;		
		private var version:int;		
		private var beanList:Vector.<Bean>=new Vector.<Bean>();
		
		private var space:KarmaSpace;
		
		public function Karma(space:KarmaSpace) {
			this.space = space;
		}
		
		public function get type():int
		{
			return type_;
		}
		
		public function fromType(type:int):Karma {
			this.type_ = type;
			var kn:KarmaNow=space.getDef(type);
			if(kn==null)
				throw new Error("karma type not found");
			var history:KarmaHistory = kn.history;
			var headDef:KarmaDefV = history.getHead();
			this.version = headDef.version;
			this.beanList = headDef.generate();
			return this;
		}
		
		//==================== encoding ==============
		
		public function fromBytes(reader:ZintBuffer):void {
			var inType:int = reader.readInt();
			var inVersion:int = reader.readInt();
			if(inType==0)
				throw new Error();
			if (type != 0 && type != inType)
				throw new Error();
			
			var def:KarmaNow = space.getDef(inType);
			if (def == null) {// type not exist
				trace("error: karma type not exist",inType,this);
				return;
			}
			
			var headDef:KarmaDefV = def.history.getHead();
			if(this.type==0)
				beanList=headDef.generate();
			this.type_=inType;
			
			if (headDef.version == inVersion) {// version is head
				this.version=inVersion;
				load(reader,beanList);
				return;
			}
			
			var oldDef:KarmaDefV = def.history.getVersion(inVersion);
			if (oldDef == null) {// version not exist
				this.version = headDef.version;
				beanList = headDef.generate();
				trace("error: old version not exist: type=" + type + " version="
					+ version);
				return;
			}
			
			// update version
			var oldList:Vector.<Bean> = oldDef.generate();
			load(reader,oldList);
			beanList = headDef.update(oldDef, oldList);
			this.version=headDef.version;
			
			trace("updating: " , def.editor.core.name , "from version=" , inVersion
				, " to version=" ,version,this);
		}
		
		private function load(reader:ZintBuffer, beanList:Vector.<Bean>):void{
			for each(var bean:Bean in beanList){
				bean.readFrom(reader);
			}
		}
		
		public function toBytes():ZintBuffer {
			var writer:ZintBuffer = new ZintBuffer();
			writer.writeInt(type);
			writer.writeInt(version);
			//			writer.writeZint(beanList.length);
			for each (var bean:Bean in beanList) {
				bean.writeTo(writer);
			}
			return writer;
		}
		
		//================== get =============
		public function getBean(idx:int):Bean {
			return beanList[idx];
		}
		
		public function getBoolean(idx:int):Boolean {
			return getBean(idx).asBoolean();
		}
		
		public function getInt(idx:int):int {
			return getBean(idx).asInt();
		}
		
		public function getLong(idx:int):Number {
			return getBean(idx).asLong();
		}
		
		public function getDouble(idx:int):Number {
			return getBean(idx).asDouble();
		}
		
		public function getString(idx:int):String {
			return getBean(idx).asString();
		}
		
		public function getBytes(idx:int):ZintBuffer {
			return getBean(idx).asBytes();
		}
		
		public function getKarma(idx:int):Karma {
			return getBean(idx).asKarma();
		}
		
		public function getList(idx:int):KarmaList {
			return getBean(idx).asList();
		}
		
		//============= set =================
		public function setBoolean(idx:int, value:Boolean):void {
			getBean(idx).setBoolean(value);
		}
		
		public function setInt(idx:int, value:int):void {
			getBean(idx).setInt(value);
		}
		
		public function setLong(idx:int, value:Number):void {
			getBean(idx).setLong(value);
		}
		
		public function setDouble(idx:int, value:Number):void {
			getBean(idx).setDouble(value);
		}
		
		public function setString(idx:int, value:String):void {
			getBean(idx).setString(value);
		}
		
		public function setBytes(idx:int, value:ZintBuffer):void {
			getBean(idx).setBytes(value);
		}
		
		public function setKarma(idx:int, value:Karma):void {
			if(value == this)
				throw new Error();
			
			getBean(idx).setKarma(value);
		}
		
		//================= mod ================
		/** 
		 * * @return new value
		 */
		public function addInt(idx:int, delta:int):int {
			var b:Bean = getBean(idx);
			var value:int = b.asInt();
			value += delta;
			b.setInt(value);
			return value;
		}
		
		/** 
		 * * @return new value
		 */
		public function addDouble(idx:int, delta:Number):Number {
			var b:Bean = getBean(idx);
			var value:Number = b.asDouble();
			value += delta;
			b.setDouble(value);
			return value;
		}
		
		
	}
	
	
}