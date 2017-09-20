package azura.banshee.zimage.i
{
	public interface ZplateRendererI
	{
		function move(x:Number,y:Number,depth:Number):void;
		function scale(value:Number):void;
		function addChild(value:ZplateRendererI):void;
		function removeChild(value:ZplateRendererI):void;
		function sortChildren():void;
	}
}