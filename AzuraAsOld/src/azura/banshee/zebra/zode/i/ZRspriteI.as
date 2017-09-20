package azura.banshee.zebra.zode.i {
	
	import azura.banshee.zebra.zode.ZframeOp;
	
	public interface ZRspriteI
	{
		function display(zs:ZframeOp):void;
		function set visible(value:Boolean):void;
		function clear():void;
		/**
		 *includes clear(); 
		 * 
		 */
		function dispose():void;
	}
}