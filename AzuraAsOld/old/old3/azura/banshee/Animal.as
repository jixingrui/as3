package azura.banshee.zanimal
{
	import azura.common.collections.ZintBuffer;
	import azura.gallerid.Gal_PackOld;
	
	import flash.utils.ByteArray;
	
	public class Animal
	{
		public var race:Race;
		[Bindable]
		public var name:String;
		public var nagaList:Vector.<Naga>=new Vector.<Naga>();
		
		public function Animal(race:Race)
		{
			this.race=race;
			for each(var d:String in race.danceList){
				nagaList.push(null);
			}
		}
		
		public function getDance(name:String):Naga{
			var idx:int=race.danceToIdx(name);
			if(idx>=nagaList.length)
				throw new Error("Animal: dance does not exist: "+name);
			else
				return nagaList[idx];
		}
		
		public function encode():ZintBuffer{
			if(nagaList.length==0)
				return null;
			
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeBytes_(race.encode());
			zb.writeUTF(name);
			zb.writeZint(nagaList.length);
			for each(var naga:Naga in nagaList){
				if(naga==null)
					return null;
				
				zb.writeBytes_(naga.encode());
			}
			return zb;
		}
		
		public static function decode(data:ByteArray):Animal{
			var zb:ZintBuffer=new ZintBuffer(data);
			//			var raceInAnimal:Race=new Race();
			var race:Race=new Race();
			race.decode(zb.readBytes_());
			
			var animal:Animal=new Animal(race);
			
			animal.name=zb.readUTF();
			zb.readZint();
			for(var i:int=0;i<race.danceList.length;i++){
				var nagaData:ZintBuffer=zb.readBytes_();
				var naga:Naga=new Naga(nagaData);
				animal.nagaList[i]=naga;
			}
			
			return animal;
		}
		
		public function extractMd5(gp:Gal_PackOld):void{
			for(var i:int=0;i<nagaList.length;i++){
				var naga:Naga=nagaList[i];
				naga.extractMd5(gp);
			}
		}
	}
}