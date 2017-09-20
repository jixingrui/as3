package azura.banshee.zebra.branch
{
	import azura.banshee.zebra.data.wrap.Zatlas2;
	import azura.banshee.zebra.data.wrap.Zframe2;
	import azura.common.collections.ZintBuffer;
	import azura.common.collections.ZintCodecI;
	
	public class Zline2 implements ZintCodecI
	{
		public var zUp_frameList:Vector.<Vector.<int>>;
		public var atlas:Zatlas2;
		
		public function Zline2()
		{
		}
		
		public function get frameCount():int{
			return zUp_frameList[0].length;
		}
		
		public function get zCount():int{
			return zUp_frameList.length;
		}
		
		public function getFrame(zUp:int,frameIdx:int):Zframe2{
			var idxInAtlas:int=zUp_frameList[zUp][frameIdx];
			return atlas.frameList[idxInAtlas];
		}
		
		public function readFrom(reader:ZintBuffer):void
		{
			var i:int;
			var j:int;
			var row:int = reader.readZint();
			var col:int = reader.readZint();
			zUp_frameList=new Vector.<Vector.<int>>();
			for ( i = 0; i < row; i++){
				var current:Vector.<int>=new Vector.<int>();
				zUp_frameList.push(current);					
				for ( j = 0; j < col; j++) {
					current.push(reader.readZint());
				}
			}
		}
		
		public function writeTo(writer:ZintBuffer):void
		{
			var i:int;
			var j:int;
			var row:int=zUp_frameList.length;
			var col:int=zUp_frameList[0].length;
			writer.writeZint(row);
			writer.writeZint(col);
			for ( i = 0; i < row; i++){
				var current:Vector.<int>=zUp_frameList[i];
				for ( j = 0; j < col; j++) {
					writer.writeZint(current[j]);
				}
			}
		}
	}
}