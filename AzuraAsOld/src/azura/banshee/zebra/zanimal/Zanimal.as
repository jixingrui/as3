package azura.banshee.zebra.zanimal
{
	import azura.banshee.zebra.Zebra;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.i.GsI;
	
	public class Zanimal implements GsI
	{
		private var _race:Zrace;
		[Bindable]
		public var name:String;
		public var zebraList:Vector.<Zebra>;
		
		public function get race():Zrace
		{
			return _race;
		}
		
		public function set race(value:Zrace):void
		{
			_race = value;
			zebraList=new Vector.<Zebra>();
			for(var i:int=0;i<value.danceList.length;i++){
				zebraList.push(new Zebra());
			}
		}
		
		public function getZebra(name:String):Zebra{
			var idx:int=race.danceToIdx(name);
			return getZebraByIdx(idx);
		}
		
		public function getZebraByIdx(idx:int):Zebra{
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
			for each(var zi:Zebra in zebraList){
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
			for each(var z:Zebra in zebraList){
				zb.writeBytesZ(z.toBytes());
			}
			return zb;
		}
		
		public function fromBytes(zb:ZintBuffer):void{
			var temp:Zrace=new Zrace();
			temp.fromBytes(zb.readBytesZ());
			race=temp;
			
			name=zb.readUTFZ();
			zb.readZint();
			for(var i:int=0;i<race.danceList.length;i++){
				var zi:Zebra=new Zebra();
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
			
			for each(var z:Zebra in zebraList)
			{
				for each(mc5 in z.getMe5List()){
					result.push(mc5);
				}
			}
			return result;
		}
		
		public function toString():String{
			return "Zanimal("+name+") "+ race.toString();
		}
	}
}
