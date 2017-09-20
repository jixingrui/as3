package azura.karma.run.bean {

	import azura.common.collections.ZintBuffer;
	import azura.karma.run.Karma;

    
    public class BeanBytes implements BeanI {
       private var value:ZintBuffer;
        
        public function readFrom(source:ZintBuffer):void {
            value = source.readBytesZ();
        }
        
        public function writeTo(dest:ZintBuffer):void {
            dest.writeBytesZ(value);
        }

        public function asInt():int {
            throw new Error();
        }
		
		public function asLong():Number{
			throw new Error();
		}
		
		public function setLong(value:Number):void{
			throw new Error();
		}
        
        public function asString():String {
            throw new Error();
        }

        
        public function asBytes():ZintBuffer {
            return value;
        }

        
        public function asDouble():Number {
            throw new Error();
        }

        
        public function asKarma():Karma {
            throw new Error();
        }
		
		public function asList():KarmaList{
			throw new Error();
		}
        
        public function setInt(value:int):void {
            throw new Error();
        }

        
        public function setString(string:String):void {
            throw new Error();
        }

        
        public function asBoolean():Boolean {
            throw new Error();
        }

        
        public function setBoolean(value:Boolean):void {
            throw new Error();
        }

        
        public function setBytes(value:ZintBuffer):void {
            this.value = value;
        }

        
        public function setDouble(value:Number):void {
            throw new Error();
        }

        
        public function setKarma(value:Karma):void {
            throw new Error();
        }
    }

    
}