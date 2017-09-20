package azura.banshee.editors
{
	import azura.banshee.zforest.Zbase;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.GsI;
	
	public class Zmibt implements GsI
	{
		public var pictureScale:Number=1;
		public var wayScale:Number=1;
		public var zmi:Zmi=new Zmi();
		public var zbase:Zbase=new Zbase();
		public var zplantedList:Vector.<Zplanted>=new Vector.<Zplanted>();
		
		public function fromBytes(zb:ZintBuffer):void
		{
			pictureScale=zb.readDouble();
			wayScale=zb.readDouble();
			zmi.fromBytes(zb.readBytes_());
			zbase.fromBytes(zb.readBytes_());
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var zt:Zplanted=new Zplanted();
				zt.fromBytes(zb.readBytes_());
				zplantedList.push(zt);
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeDouble(pictureScale);
			zb.writeDouble(wayScale);
			zb.writeBytes_(zmi.toBytes());
			zb.writeBytes_(zbase.toBytes());
			zb.writeZint(zplantedList.length);
			for each(var zt:Zplanted in zplantedList){
				zb.writeBytes_(zt.toBytes());
			}
			return zb;
		}
		
		public function getMc5List():Vector.<String>{
			var list:Vector.<String>=new Vector.<String>();
			var mc5:String;
			for each(mc5 in zmi.getMc5List()){
				list.push(mc5);	
			}
			for each(var zt:Zplanted in zplantedList){
				for each(mc5 in zt.getMc5List()){
					list.push(mc5);	
				}
			}
			return list;
		}
	}
}