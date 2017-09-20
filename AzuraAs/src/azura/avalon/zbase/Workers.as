/*******************************************************************************************************************************************
 * This is an automatically generated class. Please do not modify it since your changes may be lost in the following circumstances:
 *     - Members will be added to this class whenever an embedded worker is added.
 *     - Members in this class will be renamed when a worker is renamed or moved to a different package.
 *     - Members in this class will be removed when a worker is deleted.
 *******************************************************************************************************************************************/

package azura.avalon.zbase 
{
	
	import flash.utils.ByteArray;
	
	public class Workers
	{
		
		[Embed(source="../../../../workerswfs/azura/banshee/multithread/Core2Worker.swf", mimeType="application/octet-stream")]
		private static var azura_banshee_multithread_Core2Worker_ByteClass:Class;
		public static function get azura_banshee_multithread_Core2Worker():ByteArray
		{
			return new azura_banshee_multithread_Core2Worker_ByteClass();
		}
		
	}
}
