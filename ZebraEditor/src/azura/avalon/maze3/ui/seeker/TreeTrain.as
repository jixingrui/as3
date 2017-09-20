package azura.avalon.maze3.ui.seeker
{
	import azura.common.collections.BytesI;
	import azura.common.collections.DictionaryUtil;
	import azura.common.collections.ZintBuffer;
	
	import flash.utils.Dictionary;
	
	public class TreeTrain implements BytesI
	{
		public var id_TreeCar:Dictionary=new Dictionary();
		
		/**
		 * Assumes no car will have id==0. And 0 means no parent. This needs clarify. 
		 */
		public var idRoot:int;
		
		public function TreeTrain()
		{
		}
		
		public function getCar(id:int):TreeCar{
			return id_TreeCar[id];
		}
		
		public function fromBytes(zb:ZintBuffer):void
		{
			var size:int=zb.readZint();
			for(var i:int=0;i<size;i++){
				var car:TreeCar=new TreeCar();
				car.readFrom(zb);
				id_TreeCar[car.idCar]=car;
				if(car.parent==0)
					idRoot=car.idCar;
			}
		}
		
		public function toBytes():ZintBuffer
		{
			var length:int=DictionaryUtil.getLength(id_TreeCar);
			var zb:ZintBuffer=new ZintBuffer();
			zb.writeZint(length);
			for each(var car:TreeCar in id_TreeCar){
				car.writeTo(zb);
			}
			
			return zb;
		}
	}
}