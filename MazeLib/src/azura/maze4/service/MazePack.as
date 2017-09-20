package azura.maze4.service
{
	import azura.banshee.animal.GalPack5;
	import azura.common.collections.BytesI;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4;
	import azura.karma.def.KarmaSpace;
	
	import flash.utils.Dictionary;
	
	public class MazePack implements BytesI
	{
		public static var ksMaze:KarmaSpace;
		
		public var roomList:Vector.<RoomPack>=new Vector.<RoomPack>();
		public var gp:GalPack5=new GalPack5();
		
		public var tag_Woo:MultiMap=new MultiMap();
		
		public function MazePack()
		{
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var size:int=zb.readZint();
			for(var i:int=0;i<size;i++){
				var rp:RoomPack=new RoomPack();
				rp.fromBytes(zb.readBytesZ());
				roomList.push(rp);
				
				if(rp.kr.groundImage.length>0){
					var gpLand:GalPack5=new GalPack5();
					gpLand.fromIndex(rp.kr.groundImage);
					gp.eat(gpLand);
				}
				
				if(rp.kr.mask.length>0){
					var gpMask:GalPack5=new GalPack5();
					gpMask.fromIndex(rp.kr.mask);
					gp.eat(gpMask);
				}
				
				for each(var wp:WooPack in rp.wooList){
					if(wp.woo.animal.length>0){
						var gpAnimal:GalPack5=new GalPack5().fromIndex(wp.woo.animal);
						gp.eat(gpAnimal);
					}
				}
			}
			gp.master=Gal4.writeOne(zb);
			
			//cache
			for each(var r:RoomPack in roomList){
				for each(var w:WooPack in r.wooList){
//					tag_Woo[w.woo.tag]=w;
					tag_Woo.insertVal(w.woo.tag,w);
				}
			}
		}
		
		public function tagToWoo(tag:String):Dictionary{
			return tag_Woo.getVals(tag);
//			return tag_Woo[tag];
		}
		
		public function toBytes():ZintBuffer{
			return null;
		}
	}
}