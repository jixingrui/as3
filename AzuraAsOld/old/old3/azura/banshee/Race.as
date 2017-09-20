package azura.banshee.zanimal
{
	import azura.common.collections.ZintBuffer;
	import azura.common.panels.AlertPanel;
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;
	
	[Bindable]
	public class Race
	{
		public var name:String;
		public var danceList:ArrayCollection=new ArrayCollection();
		public var sealed:Boolean=false;
		
		public function danceToIdx(name:String):int{
			var idx:int=0;
			for(;idx<danceList.length;idx++){
				if(danceList[idx]==name)
					break;
			}
			return idx;
		}
		
		public function addDance(dance:String):void{
			if(!sealed)
				danceList.addItem(dance);
			else
				AlertPanel.show("sealed");
		}
		
		public function encode():ZintBuffer{
			sealed=true;
			
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTF(name);
			zb.writeZint(danceList.length);
			for each(var d:String in danceList){
				zb.writeUTF(d);
			}
			return zb;
		}
		
		public function decode(data:ByteArray):void{
			sealed=true;
			
			var zb:ZintBuffer=new ZintBuffer(data);
			name=zb.readUTF();
			danceList.removeAll();
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				danceList.addItem(zb.readUTF());
			}
		}
	}
}