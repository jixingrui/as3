package old.azura.avalon.ice.land
{
	import azura.banshee.zebra.zimage.large.TileZimage;
	import azura.banshee.zebra.zimage.large.TileZimage;

	public interface LandUserI
	{
		function _updateTile(tile:TileZimage):void;
		function _removeTile(tile:TileZimage):void;
	}
}