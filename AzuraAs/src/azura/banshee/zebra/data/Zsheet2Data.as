package azura.banshee.zebra.data
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;

	public class Zsheet2Data implements BytesI
	{
		/**
		 * {bitmap,atf_win,atf_and,atf_ios}
		 */
		protected var platformList:Vector.<String>=new Vector.<String>(4);
		private var width:int;
		private var height:int;
		
		public function fromBytes(zb:ZintBuffer):void
		{
			width=zb.readZint();
			height=zb.readZint();
			platformList[0]=zb.readUTFZ();
			platformList[1]=zb.readUTFZ();
			platformList[2]=zb.readUTFZ();
			platformList[3]=zb.readUTFZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(width);
			zb.writeZint(height);
			zb.writeUTFZ(platformList[0]);
			zb.writeUTFZ(platformList[1]);
			zb.writeUTFZ(platformList[2]);
			zb.writeUTFZ(platformList[3]);
			return zb;
		}
	}
}