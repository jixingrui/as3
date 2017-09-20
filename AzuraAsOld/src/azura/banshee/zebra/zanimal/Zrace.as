package azura.banshee.zebra.zanimal
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	[Bindable]
	public class Zrace implements BytesI
	{
		public var name:String;
		public var danceList:Vector.<Zpose>=new Vector.<Zpose>();
		public var sealed:Boolean=false;
		
		public function get isReady():Boolean{
			var good:Boolean=true;
			if(name==null||name.length==0)
				good=false;
			if(danceList.length==0)
				good=false;
			for each(var item:Zpose in danceList){
				if(item.name==null || item.name.length==0)
					good=false;
			}
			return good;
		}
		
		public function equals(other:Zrace):Boolean{
			var good:Boolean=true;
			if(name!=other.name)
				good=false;
			if(danceList.length!=other.danceList.length)
				good=false;
			for (var i:int=0;i<danceList.length;i++){
				if(danceList[i].name != other.danceList[i].name)
					good=false;
			}
			return good;
		}
		
		public function danceToIdx(name:String):int{
			var idx:int=0;
			for(;idx<danceList.length;idx++){
				if(danceList[idx].name==name)
					break;
			}
			return idx;
		}
		
		//		public function addDance(dance:String):void{
		//			if(!sealed)
		//				danceList.push(new Zdance(dance));
		//			else
		//				AlertPanel.show("sealed");
		//		}
		
		public function toBytes():ZintBuffer{
			sealed=true;
			
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(name);
			zb.writeZint(danceList.length);
			for each(var d:Zpose in danceList){
				zb.writeBytesZ(d.toBytes());
			}
			return zb;
		}
		
		public function fromBytes(data:ZintBuffer):void{
			sealed=true;
			
			var zb:ZintBuffer=new ZintBuffer(data);
			name=zb.readUTFZ();
			danceList=new Vector.<Zpose>();
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var zd:Zpose=new Zpose();
				zd.fromBytes(zb.readBytesZ());
				danceList.push(zd);
			}
		}
		
		public function toString():String{
			var result:String= "Zrace("+name+") ";
			for each(var d:Zpose in danceList){
				result+=d.name+" ";
			}
			return result;
		}
		
		public function clear():void{
			name='';
			sealed=false;
			danceList=new Vector.<Zpose>();
		}
	}
}