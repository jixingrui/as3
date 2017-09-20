package azura.avalon.maze3.data
{
	import azura.common.collections.ZintBuffer;
	import azura.helios.hard10.ie.HardReaderI;
	
	[Bindable]
	public class Helix implements HardReaderI
	{
		public var isLeaf:Boolean;
		public var listIcon:String;
		public var gridIcon:String;
		public var toWooName:String;
		public var toWooUid:String;
		
		public function Helix()
		{
		}
		
		public function init():void
		{
			isLeaf=true;
			listIcon='';
			gridIcon='';
			toWooName='';
			toWooUid='';
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			isLeaf=zb.readBoolean();
			listIcon=zb.readUTFZ();
			gridIcon=zb.readUTFZ();
			toWooName=zb.readUTFZ();
			toWooUid=zb.readUTFZ();
		}
		
		public function toBytes():ZintBuffer
		{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBoolean(isLeaf);
			zb.writeUTFZ(listIcon);
			zb.writeUTFZ(gridIcon);
			zb.writeUTFZ(toWooName);
			zb.writeUTFZ(toWooUid);
			return zb;
		}
	}
}