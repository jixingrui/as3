package azura.banshee.zebra
{
	import azura.banshee.zebra.i.ZebraI;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	import flash.geom.Rectangle;
	
	public class Zcombo implements ZebraI
	{
		[Bindable]
		public var partList:Vector.<Zebra>=new Vector.<Zebra>();
		
		public function Zcombo()
		{
		}
		
		public function get width():int
		{
			return 0;
		}
		
		public function get height():int
		{
			return 0;
		}
		
		public function get boundingBox():Rectangle{
			return new Rectangle();
		}
		
		public function addPart(idx:int,zebra:Zebra):void{
			
//			if(zebra.format=="zcombo"){
//				var c:Zcombo=Zcombo(zebra.branch);
//				for each(var zp:Zebra in c.partList){
//					partList.splice(idx++,0,zp);
//				}
//			}else{
//				partList.splice(idx,0,zebra);
//			}
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var part:Zebra=new Zebra();
				part.fromBytes(zb.readBytesZ());
				partList.push(part);
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(partList.length);
			for each(var p:Zebra in partList){
				zb.writeBytesZ(p.toBytes());
			}
			return zb;
		}
		
		public function getMe5List():Vector.<String>
		{
			var list:Vector.<String>=new Vector.<String>(); 
			for each(var part:Zebra in partList){
				for each(var mc5:String in part.getMe5List()){
					list.push(mc5);
				}
			}
			return list;
		}
		
		public function clear():void
		{
		}
	}
}