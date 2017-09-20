package azura.common.collections
{
	import flash.utils.ByteArray;
	
	
	public class ZintBuffer extends ByteArray
	{
		public function ZintBuffer(source:ByteArray=null)
		{
			if(source!=null){
				super.writeBytes(source);
				super.position=0;
			}
		}
		
		public function readZint():int{
			return Zint.readIntZ(this);
		}
		
		public function writeZint(value:int):void{
			Zint.writeIntZ(value,this);
		}
		
		public function readLongZ():Number{
			return Zint.readLongZ(this);
		}
		
		public function writeLongZ(value:Number):void{
			return Zint.writeLongZ(value,this);
		}
		
		/**
		 *  Warning: Number has precision problem
		 * 
		 */
		public function readLong():Number{
			return ( this.readUnsignedByte() & 0xff) << 56
				| ( this.readUnsignedByte() & 0xff) << 48
				| ( this.readUnsignedByte() & 0xff) << 40
				| ( this.readUnsignedByte() & 0xff) << 32
				| ( this.readUnsignedByte() & 0xff) << 24
				| ( this.readUnsignedByte() & 0xff) << 16
				| ( this.readUnsignedByte() & 0xff) << 8
				|  this.readUnsignedByte() & 0xff;
		}
		
		public function writeLong(value:Number):void{
			this.writeByte( value >>> 56);
			this.writeByte(value >>> 48);
			this.writeByte( value >>> 40);
			this.writeByte(value >>> 32);
			this.writeByte(value >>> 24);
			this.writeByte(value >>> 16);
			this.writeByte(value >>> 8);
			this.writeByte(value);
		}
		
		public function readBytesZ():ZintBuffer{
			var result:ZintBuffer=new ZintBuffer();
			var length:int=readZint();
			if(length>0)
				super.readBytes(result,0,length);
			return result;
		}
		
		public function writeBytesZ(value:ByteArray):void{
			if(value==null)
				value=new ByteArray();
			value.position=0;
			writeZint(value.bytesAvailable);
			writeBytes(value);
		}
		
		public function writeBytesZB(value:ZintBuffer):void{
			if(value==null)
				value=new ZintBuffer();
			value.position=0;
			writeZint(value.bytesAvailable);
			writeBytes(value);
		}
		
		public function readUTFZ():String{
			var length:int = readZint();
			if (length > 0) {
				return readUTFBytes(length);
			} else {
				return "";
			}
		}
		
		public function writeUTFZ(value:String):void{
			if(value==null)
				writeZint(0);
			else{
				var ba:ByteArray=new ByteArray();
				ba.writeMultiByte(value,"UTF-8");
				
				writeZint(ba.length);
				writeBytes(ba);
			}
		}
		
//		override public function readUTF():String{
//			throw new Error();
			//			var length:int = readZint();
			//			if (length > 0) {
			//				return readUTFBytes(length);
			//			} else {
			//				return "";
			//			}
//		}
		
//		override public function writeUTF(value:String):void{
//			throw new Error();
			//			if(value==null)
			//				writeZint(0);
			//			else{
			//				var ba:ByteArray=new ByteArray();
			//				ba.writeMultiByte(value,"utf-8");
			//				
			//				writeZint(ba.length);
			//				writeBytes(ba);
			//			}
//		}
		
		public function clone():ZintBuffer{
			return new ZintBuffer(this);
		}
		
		public function isEmpty():Boolean{
			return this.bytesAvailable==0;
		}
	}
}