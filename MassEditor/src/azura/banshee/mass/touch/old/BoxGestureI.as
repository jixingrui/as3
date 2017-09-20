package azura.banshee.mass.touch.old
{
	public interface BoxGestureI
	{
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