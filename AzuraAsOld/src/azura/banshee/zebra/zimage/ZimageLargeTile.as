package azura.banshee.zebra.zimage
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.TileFi;
	import azura.common.collections.ZintBuffer;
	import azura.common.util.OS;
	import azura.gallerid3.i.GsI;
	
	public class ZimageLargeTile extends TileFi implements GsI
	{
		public static var init:int=0;
		public static var empty:int=1;
		public static var alpha:int=2;
		public static var solid:int=3;
		public var textureType:int;	
		/**
		 * {png/jpg,atf_win,atf_and,atf_ios}
		 */
		private var platformList:Vector.<String>=new Vector.<String>();
		
		public function ZimageLargeTile(fi:int, pyramid:PyramidFi)
		{
			super(fi, pyramid);
		}
		
		public function get mc5():String{
			if(OS.isPc)
				return platformList[1];
			else if(OS.isAndroid)
				return platformList[2];
			else 
				return platformList[3];
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			textureType=zb.readZint();
			if(textureType==empty)
				return;
			
			platformList.push(zb.readUTFZ());
			platformList.push(zb.readUTFZ());
			platformList.push(zb.readUTFZ());
			platformList.push(zb.readUTFZ());
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(textureType);
			if(textureType==empty)
				return zb;
			
			zb.writeUTFZ(platformList[0]);
			zb.writeUTFZ(platformList[1]);
			zb.writeUTFZ(platformList[2]);
			zb.writeUTFZ(platformList[3]);
			return zb;
		}
		
		public function clear():void{
			
		}
		
		public function getMe5List():Vector.<String>{
			return platformList;
		}
	}
}