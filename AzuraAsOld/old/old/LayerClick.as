package azura.banshee.starling.layers
{
	import azura.avalon.fi.PyramidFi;
	import azura.avalon.fi.base.PyramidBase;
	
	import common.algorithm.FastMath;
	
	import flash.utils.Dictionary;
	import azura.banshee.starling.GroundItem;

	public class LayerClick extends PyramidFi
	{
		private var Item_Item:Dictionary=new Dictionary();
		
		public function LayerClick(){
//			var item:Item=new Item();
//			item.x=100;
//			item.y=100;
//			putItem(item);
		}
		
		public function clear():void{
			for each(var item:GroundItem in Item_Item){
				removeItem(item);
			}
		}
		
		public function putItem(item:GroundItem):void{
			Item_Item[item]=item;
		}
		
		public function removeItem(item:GroundItem):void{
			delete Item_Item[item];
		}
		
		public function getItem(x:int,y:int):GroundItem{
			for each(var item:GroundItem in Item_Item){
//				trace(x+","+y+" "+item.x+","+item.y);
				if(FastMath.dist(item.xFc, item.yFc, x, y)<50)
					return item;				
			}
			return null;
		}
	}
}