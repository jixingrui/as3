package azura.banshee.zebra.zmotion
{
	import azura.banshee.zebra.atlas.Zatlas;
	import azura.banshee.zebra.atlas.Zframe;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.GsI;
	
	import flash.geom.Rectangle;
	
	public class Zline implements GsI{
		
		public var frames:int;
		public var layerList:Vector.<Zatlas>=new Vector.<Zatlas>();
		private var bb:Rectangle;
		
		public function get boundingBox():Rectangle{
			return bb;
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{		
			frames=zb.readZint();
			
			var layerCount:int=zb.readZint();
			layerList=new Vector.<Zatlas>();
			for(var i:int=0;i<layerCount;i++){
				var layer:Zatlas=new Zatlas();
				layer.fromBytes(zb.readBytesZ());
				layerList.push(layer);
			}
			
			var atlas:Zatlas=layerList[0];
			bb=new Rectangle();
			for each(var frame:Zframe in atlas.frameList){
				bb.left+=frame.boundingBox.left;
				bb.right+=frame.boundingBox.right;
				bb.top+=frame.boundingBox.top;
				bb.bottom+=frame.boundingBox.bottom;
			}
			bb.left/=atlas.frameList.length;
			bb.right/=atlas.frameList.length;
			bb.top/=atlas.frameList.length;
			bb.bottom/=atlas.frameList.length;
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(frames);
			zb.writeZint(layerList.length);
			for(var i:int=0;i<layerList.length;i++){
				zb.writeBytesZ(layerList[i].toBytes());
			}
			return zb;
		}
		
		public function getMe5List():Vector.<String>{
			var result:Vector.<String>=new Vector.<String>();
			for each(var s:Zatlas in layerList){
				for each(var mc5:String in s.getMe5List()){
					result.push(mc5);
				}
			}
			return result;
		}
	}
}