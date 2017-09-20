package azura.banshee.zbox3.container
{
	
	import azura.banshee.engine.TextureResI;
	
	import flash.geom.Rectangle;
	
	import starling.display.Sprite;

	/**
	 *  two items are included. 
	 * the first one is a container. 
	 * the second one is a image display unit, which will be created when there is something to display.
	 * 
	 */
	public interface Zbox3ReplicaI
	{
//		function get loader():TextureLoader2I;
		function replicate():Zbox3ReplicaI;
		
		//======== customize =====
		function get starlingSprite():Sprite;
		
		//======== tree =========
		function removeChild(child:Zbox3ReplicaI):void;
		function swapChildren(idx1:int,idx2:int):void;
		
		//======== self ========
		function display(res:TextureResI):void;
		function unDisplay():void;
		
		function get scaleXImage():Number;
		function set scaleXImage(value:Number):void;
		function set scaleYImage(value:Number):void;
		
		//display
		function set clipRect(rect:Rectangle):void;
		function set visible(value:Boolean):void;		
		function get visible():Boolean;
		function set alpha(value:Number):void;
		function get alpha():Number;
		function set scaleX(value:Number):void;
		function set scaleY(value:Number):void;
		function set rotation(angle:Number):void;
		function set smoothing(value:Boolean):void;
		function get smoothing():Boolean;
		
		/**
		 * The distance when scale==1
		 */
		function set x(value:Number):void;
		/**
		 * The distance when scale==1
		 */
		function set y(value:Number):void;
		function set width(value:Number):void;
		function set height(value:Number):void;
	}
}