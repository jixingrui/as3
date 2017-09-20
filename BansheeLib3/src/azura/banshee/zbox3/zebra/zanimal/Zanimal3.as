package azura.banshee.zbox3.zebra.zanimal
{
	import azura.banshee.zebra.Zebra3;
	import azura.common.collections.ZintBuffer;
	
	public class Zanimal3
	{
		private var _race:Zrace3;
		[Bindable]
		public var name:String;
		public var zebraList:Vector.<Zebra3>;
		
		public function get race():Zrace3
		{
			return _race;
		}
		
		public function set race(value:Zrace3):void
		{
			_race = value;
			zebraList=new Vector.<Zebra3>();
			for(var i:int=0;i<value.danceList.length;i++){
				zebraList.push(new Zebra3());
			}
		}
		
		public function getZebra(name:String):Zebra3{
			var idx:int=race.danceToIdx(name);
			return getZebraByIdx(idx);
		}
		
		public function getZebraByIdx(idx:int):Zebra3{
			if(idx>=zebraList.length)
				throw new Error("Animal: dance does not exist: "+name);
			else
				return zebraList[idx];
		}
		
		public function get isReady():Boolean{
			var good:Boolean=true;
			if(name==null||name.length==0)
				good=false;
			if(zebraList.length==0)
				good=false;
			for each(var zi:Zebra3 in zebraList){
				if(zi.branch==null)
					good=false;
			}
			return good;
		}
		
		public function toBytes():ZintBuffer{
			if(zebraList.length==0)
				return null;
			
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytesZ(race.toBytes());
			zb.writeUTFZ(name);
			zb.writeZint(zebraList.length);
			for each(var z:Zebra3 in zebraList){
				zb.writeBytesZ(z.toBytes());
			}
			return zb;
		}
		
		public function fromBytes(zb:ZintBuffer):void{
			var temp:Zrace3=new Zrace3();
			temp.fromBytes(zb.readBytesZ());
			race=temp;
			
			name=zb.readUTFZ();
			zb.readZint();
			for(var i:int=0;i<race.danceList.length;i++){
				var zi:Zebra3=new Zebra3();
				zebraList[i]=zi;
				zi.fromBytes(zb.readBytesZ());
			}
		}
		
		public function clear():void{
			_race=null;
			name='';
			zebraList=null;
		}
		
		public function getMe5List():Vector.<String>
		{
			var mc5:String;
			var result:Vector.<String>=new Vector.<String>();
			
			for each(var z:Zebra3 in zebraList)
			{
				z.getMc5List(result);
			}
			return result;
		}
		
		public function toString():String{
			return "Zanimal("+name+") "+ race.toString();
		}
	}
}
