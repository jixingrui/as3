package azura.banshee.mass.touch.old
{
	public interface TouchGestureI
	{
		//original
		function tgDown():void;
		function tgMove(x:Number,y:Number):void;
		function tgUp():void;

		//gesture
		function tgOver():void;
		function tgOut():void;
		function tgSelect():void;
		function tgDouble():void;
		function tgDrag(x:Number,y:Number):void;
		function tgDrop():void;
		function tgZoom(scaleDX:Number,scaleDY:Number):void;
		function tgRotate(angle:Number):void;
	}
}