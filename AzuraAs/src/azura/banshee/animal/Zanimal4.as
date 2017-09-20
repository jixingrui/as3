package azura.banshee.animal
{
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4;
	
	import flash.utils.ByteArray;
	
	public class Zanimal4 
	{
		private var _race:Zrace4=new Zrace4();
		[Bindable]
		public var name:String;
		private var _shapeList:Vector.<GalPack5>=new Vector.<GalPack5>();
		
		[Bindable]
		public function get race():Zrace4
		{
			return _race;
		}
		
		public function set race(value:Zrace4):void
		{
			_race = value;
			seal();
		}
		
		public function get shapeList():Vector.<GalPack5>
		{
			return _shapeList;
		}
		
		public function set shapeList(value:Vector.<GalPack5>):void
		{
			_shapeList = value;
		}
		
		public function seal():void
		{
			race.sealed=true;
			shapeList=new Vector.<GalPack5>();
			for(var i:int=0;i<race.poseList.length;i++){
				shapeList.push(new GalPack5());
			}
		}
		
		public function getShape(name:String):GalPack5{
			var idx:int=race.danceToIdx(name);
			return getShapeByIdx(idx);
		}
		
		public function getShapeByIdx(idx:int):GalPack5{
			if(idx<0||idx>=shapeList.length)
				throw new Error("Animal: shape does not exist: "+name);
			else{
				return shapeList[idx];
			}
		}
		
		private function toBytes():ZintBuffer{
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytesZ(race.toBytes());
			zb.writeUTFZ(name);
			for(var i:int=0;i<race.poseList.length;i++){
				var s:GalPack5=shapeList[i];
				zb.writeBytesZ(s.toIndex());
			}
			return zb;
		}
		
		private function fromBytes(zb:ZintBuffer):void{
			_race=new Zrace4();
			_race.fromBytes(zb.readBytesZ());
			_race.sealed=true;
			
			name=zb.readUTFZ();
			for(var i:int=0;i<race.poseList.length;i++){
				var gp:GalPack5=new GalPack5();
				gp.fromIndex(zb.readBytesZ());
				shapeList[i]=gp;
			}
		}
		
		public function toPack():GalPack5{
			
			var gp:GalPack5=new GalPack5();
			
			gp.master=Gal4.writeOne(toBytes());
			for each(var s:GalPack5 in shapeList){
				gp.eat(s);
			}
			
			return gp;
		}
		
		public function fromPack(gp:GalPack5):Zanimal4{
			var master:ZintBuffer=Gal4.readSync(gp.master);
			fromBytes(master);
			return this;
		}
		
		public function clear():void{
			race.clear();
			name='';
			shapeList=new Vector.<GalPack5>();
		}
		
		public function toString():String{
			return "Zanimal("+name+") "+ race.toString();
		}
	}
}
