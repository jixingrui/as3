package azura.karma.def {
	
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	import azura.karma.run.Karma;
	import azura.karma.run.bean.BeanBoolean;
	import azura.karma.run.bean.BeanBytes;
	import azura.karma.run.bean.BeanDouble;
	import azura.karma.run.bean.BeanI;
	import azura.karma.run.bean.BeanInt;
	import azura.karma.run.bean.BeanKarma;
	import azura.karma.run.bean.BeanList;
	import azura.karma.run.bean.KarmaList;
	import azura.karma.run.bean.BeanLong;
	import azura.karma.run.bean.BeanString;
	import azura.karma.run.bean.BeanTypeE;
	
	
	public class Bean implements BeanI {
		
		public var data:BeanI;
		
		function Bean(field:KarmaFieldV) {
			this.data = typeToData(field);
		}
		
		public function readFrom(reader:ZintBuffer):void {
			data.readFrom(reader);
		}
		
		public function writeTo(writer:ZintBuffer):void {
			data.writeTo(writer);
		}
			
		public function asInt():int {
			return data.asInt();
		}
		
		public function asLong():Number{
			return data.asLong();
		}
		
		public function asString():String {
			return data.asString();
		}
		
		public function asBoolean():Boolean {
			return data.asBoolean();
		}
		
		public function asBytes():ZintBuffer {
			return data.asBytes();
		}
		
		public function asDouble():Number {
			return data.asDouble();
		}
		
		public function asKarma():azura.karma.run.Karma {
			return data.asKarma();
		}
		
		public function asList():KarmaList{
			return data.asList();
		}
		
		public function setInt(value:int):void {
			data.setInt(value);
		}
		
		public function setLong(value:Number):void {
			data.setLong(value);
		}
		
		public function setString(value:String):void {
			data.setString(value);
		}
		
		public function setBoolean(value:Boolean):void {
			data.setBoolean(value);
		}
		
		public function setBytes(value:ZintBuffer):void {
			data.setBytes(value);
		}
		
		public function setDouble(value:Number):void {
			data.setDouble(value);
		}
		
		public function setKarma(value:Karma):void {
			data.setKarma(value);
		}
		
		private function typeToData(field:KarmaFieldV):BeanI {
			
			var data:BeanI = null;
			switch (field.type) {
				case BeanTypeE.BOOLEAN :
				{
					data = new BeanBoolean();
					break;
				}
				case BeanTypeE.INT :
				{
					data = new BeanInt();
					break;
				}
				case BeanTypeE.LONG :
				{
					data = new BeanLong();
					break;
				}
				case BeanTypeE.DOUBLE :
				{
					data = new BeanDouble();
					break;
				}
				case BeanTypeE.STRING :
				{
					data = new BeanString();
					break;
				}
				case BeanTypeE.BYTES :
				{
					data = new BeanBytes();
					break;
				}
				case BeanTypeE.KARMA :
				{
					data = new BeanKarma(field);
					break;
				}
				case BeanTypeE.LIST :
				{
					data = new BeanList(field);
					break;
				}
				case BeanTypeE.EMPTY :
				{
					data = null;
					break;
				}
			}
			return data;
		}
	}
	
	
}