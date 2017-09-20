package azura.banshee.zbox2.engine
{
	import azura.banshee.engine.video.VideoI;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.banshee.zebra.data.wrap.Zframe2I;
	import azura.banshee.zebra.data.wrap.Zsheet2;
	import azura.banshee.zebra.data.wrap.TextureLoaderI;
	import azura.banshee.zebra.branch.Zbitmap2;
	
	import flash.geom.Rectangle;

	/**
	 *  two items are included. 
	 * the first one is a container. 
	 * the second one is a image display unit, which will be created when there is something to display.
	 * 
	 */
	public interface Zbox2ReplicaI extends TextureLoaderI
	{
		function replicate():Zbox2ReplicaI;
		
		//======== tree =========
		function addChild(child:Zbox2ReplicaI):void;
		function removeChild(child:Zbox2ReplicaI):void;
		function swapChildren(idx1:int,idx2:int):void;
		
		//======== self ========
		
//		function loadFrame(zframe:Zframe2):void;
//		function unloadFrame(zframe:Zframe2):void;
//		function loadSheet(zsheet:Zsheet2):void;
//		function unloadSheet(zsheet:Zsheet2):void;
		
//		function loadFrameBitmap(source:Zbitmap2):void;
//		function unloadFrameBitmap(source:Zbitmap2):void;
//		
//		function loadFromVideoUrl(url:String):VideoI;
		
		/**
		 * 
		 * @param target should not be null and the texture should be ready
		 * 
		 */
		function display(target:Zframe2I):void;
		function unDisplay():void;
		
		function set clipRect(rect:Rectangle):void;
		
		//display
		function set visible(value:Boolean):void;		
		function get visible():Boolean;
		function set alpha(value:Number):void;
		function set scaleX(value:Number):void;
		function set scaleY(value:Number):void;
		function set rotation(angle:Number):void;
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set width(value:Number):void;
		function set height(value:Number):void;
	}
}