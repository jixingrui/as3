package azura.banshee.zebra.data.wrap
{
	import azura.banshee.zebra.branch.ZbitmapI;

	public interface TextureLoaderI
	{
		function loadFrameFromSheet(frame:Zframe2):void;
		function unloadFrameFromSheet(frame:Zframe2):void;
		function loadSheet(sheet:Zsheet2):void;
		function unloadSheet(sheet:Zsheet2):void;
		
		function fromBitmap(source:ZbitmapI):void;
		function unloadBitmap(source:ZbitmapI):void;		
		
//		function loadVideo(loader:Zbox3LoaderLinkVideo):void;
		
//		function loadFromVideoUrlOld(url:String,ret_null:Function=null):VideoI;
	}
}