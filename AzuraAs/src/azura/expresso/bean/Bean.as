package azura.expresso.bean {
	import azura.common.collections.ZintBuffer;
	import azura.expresso.Datum;
	
	import flash.utils.ByteArray;
	
	public interface Bean {
		
		function change(newValue:Bean):void;
		
		function addEventListener(ret_newBean_oldBean:Function):void ;
		
		function readFrom(source:ZintBuffer):void ;
		
		function writeTo(dest:ZintBuffer):void ;
		
		function eat(pray:Bean):void ;
		
		function asInt():int ;
		
		function asString():String ;
		
		function asBoolean():Boolean ;
		
		function asBytes():ZintBuffer;
		
		function asDouble():Number ;
		
		function asDatum():Datum ;
		
		function asBeanList():BeanList;
		
		function setInt(value:int):void ;
		
		function setString(value:String):void ;
		
		function setBoolean(value:Boolean):void ;
		
		function setBytes(value:ByteArray):void ;
		
		function setDouble(value:Number):void ;
		
		function setDatum(value:Datum):void ;
		
	}
}