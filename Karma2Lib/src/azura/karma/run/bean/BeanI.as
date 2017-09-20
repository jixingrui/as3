package azura.karma.run.bean {
	
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	import azura.karma.run.Karma;
	
	import flash.utils.ByteArray;
	
	
	public interface BeanI extends ZintCodecI {
		
		 function asInt():int;
		 
		 function asLong():Number;
		
		 function asString():String;
		
		 function asBoolean():Boolean;
		
		 function asBytes():ZintBuffer;
		
		 function asDouble():Number;
		
		 function asKarma():Karma;
		
		 function asList():KarmaList;
		
		 function setInt(value:int):void;
		 
		 function setLong(value:Number):void;
		
		 function setString(value:String):void;
		
		 function setBoolean(value:Boolean):void;
		
		 function setBytes(value:ZintBuffer):void;
		
		 function setDouble(value:Number):void;
		
		 function setKarma(value:Karma):void;
	}
	
	
}