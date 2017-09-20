package azura.banshee.editors.zforest
{
	import azura.banshee.zforest.Zbase;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.GsI;
	
	public class Zforest implements GsI
	{
		public var scalePercent:int=100;
		public var zmi:Zmi=new Zmi();
		public var zbase:Zbase=new Zbase();
		public var zplantedList:Vector.<Zplanted>=new Vector.<Zplanted>();
		public var zway:Zway;
		
		public var zbaseScale:int;
		
		public function loadZway(data:ZintBuffer):void{
			zway=new Zway();
			zway.fromBytes(data);
			zbaseScale=FastMath.pow2(zbase.zMax-zway.base.zMax);
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			scalePercent=zb.readZint();
			zmi.fromBytes(zb.readBytesZ());
			zbase.fromBytes(zb.readBytesZ());
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var zt:Zplanted=new Zplanted();
				zt.fromBytes(zb.readBytesZ());
				zplantedList.push(zt);
			}
			loadZway(zb.readBytesZ());
		}
		
		public function toBytes():ZintBuffer
		{
			if(zway==null)
				zway=new Zway();
			
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(scalePercent);
			zb.writeBytesZ(zmi.toBytes());
			zb.writeBytesZ(zbase.toBytes());
			zb.writeZint(zplantedList.length);
			for each(var zt:Zplanted in zplantedList){
				zb.writeBytesZ(zt.toBytes());
			}
			zb.writeBytesZ(zway.toBytes());
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


//		public function fromBytes(zb:ZintBuffer):void
//		{
//			zmibt.fromBytes(zb.readBytes_());
//			zway.fromBytes(zb.readBytes_());
//		}
//		
//		public function toBytes():ZintBuffer
//		{
//			var zb:ZintBuffer=new ZintBuffer();
//			zb.writeBytes_(zmibt.toBytes());
//			zb.writeBytes_(zway.toBytes());
//			return zb;
//		}
//		
//		public function getMc5List():Vector.<String>{
//			return zmibt.getMc5List();
//		}