package azura.banshee.zebra.atlas
{
	import azura.common.collections.ZintBuffer;
	import azura.common.util.OS;
	import azura.gallerid3.i.GsI;
	
	public class Zsheet implements GsI
	{
		/**
		 * {png,atf_win,atf_and,atf_ios}
		 */
		private var platformList:Vector.<String>=new Vector.<String>(4);
		
		public function get me5():String{
			if(OS.isPc)
				return platformList[1];
			else if(OS.isAndroid)
				return platformList[2];
			else if(OS.isIos)
				return platformList[3];
			else 
				throw new Error("Zsheet: unknown platform");
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			platformList[0]=zb.readUTFZ();
			platformList[1]=zb.readUTFZ();
			platformList[2]=zb.readUTFZ();
			platformList[3]=zb.readUTFZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(platformList[0]);
			zb.writeUTFZ(platformList[1]);
			zb.writeUTFZ(platformList[2]);
			zb.writeUTFZ(platformList[3]);
			return zb;
		}
		
		public function clear():void{
		}
		
		public function getMe5List():Vector.<String>
		{
			return platformList;
		}
		
	}
}