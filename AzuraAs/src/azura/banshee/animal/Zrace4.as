package azura.banshee.animal
{
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	
	[Bindable]
	public class Zrace4 implements BytesI
	{
		public var name:String;
		public var poseList:Vector.<String>=new Vector.<String>();
		public var sealed:Boolean=false;
		
		public function get isReady():Boolean{
			var good:Boolean=true;
			if(name==null||name.length==0)
				good=false;
			if(poseList.length==0)
				good=false;
			for each(var item:String in poseList){
				if(item==null || item.length==0)
					good=false;
			}
			return good;
		}
		
		public function equals(other:Zrace4):Boolean{
			var good:Boolean=true;
			if(name!=other.name)
				good=false;
			if(poseList.length!=other.poseList.length)
				good=false;
			for (var i:int=0;i<poseList.length;i++){
				if(poseList[i] != other.poseList[i])
					good=false;
			}
			return good;
		}
		
		public function danceToIdx(name:String):int{
			for(var idx:int=0;idx<poseList.length;idx++){
				if(poseList[idx]==name)
					return idx;
			}
			return -1;
		}
				
		public function toBytes():ZintBuffer{
			sealed=true;
			
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeUTFZ(name);
			zb.writeZint(poseList.length);
			for each(var d:String in poseList){
				zb.writeUTFZ(d);
			}
			return zb;
		}
		
		public function fromBytes(data:ZintBuffer):void{
			sealed=true;
			
			var zb:ZintBuffer=new ZintBuffer(data);
			name=zb.readUTFZ();
			poseList=new Vector.<String>();
			var length:int=zb.readZint();
			for(var i:int=0;i<length;i++){
				var pose:String=zb.readUTFZ();
				poseList.push(pose);
			}
		}
		
		public function toString():String{
			var result:String= "Zrace("+name+") ";
			for each(var d:String in poseList){
				result+=d+" ";
			}
			return result;
		}
		
		public function clear():void{
			name='';
			sealed=false;
			poseList=new Vector.<String>();
		}
	}
}