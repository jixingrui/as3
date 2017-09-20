package azura.banshee.zebra.zode.i
{
	import flash.geom.Rectangle;

	public interface ZRnodeI extends ZRloaderI
	{
		function newChild():ZRnodeI;		
		
		function newSprite():ZRspriteI;
		
		function dispose():void;
		
		function enterFrame():void;
		function sortChildren():void;
		
		function move(xc:Number,yc:Number,depth:Number):void;		
		
		function set visible(value:Boolean):void;
		
		function set rotation(angle:Number):void;
		
		function set scaleX(value:Number):void;
		
		function set scaleY(value:Number):void;
		
		function set mask(rect:Rectangle):void;
		
		function set alpha(value:Number):void;
		function get alpha():Number;
	}
}