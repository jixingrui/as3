package old.azura.avalon.ice
{
	import old.azura.avalon.ice.layers.LayerAssG;
	import old.azura.avalon.ice.layers.LayerPictureG;
	import azura.avalon.ice.DoorI;
	import old.azura.avalon.ice.plain.PlainCarrier;
	import old.azura.avalon.ice.swamp.SwampOld;
	
	import flash.display.Stage;

	public class GlobalState
	{
		public static var stage:Stage;
		public static var swamp:SwampOld;
		public static var primePlain:PlainCarrier;
		public static var panoPlayer:PanoPlayerI;
		public static var doorHolder:DoorI;
		private static var sortFlag:Boolean;
		private static var sortCounter:int;
		
//		public static var applicationDpi:int=160;
		
		public static var layerPictureG:LayerPictureG;
		
		public static function requestSort(now:Boolean):void{
			sortFlag=true;
			if(now)
				sortCounter=0;
		}
		
		public static function shouldSort():Boolean{
			if(!sortFlag)
				return false;
			
			sortCounter--;
			if(sortCounter<=0){
				sortFlag=false;
				sortCounter=5;
				return true;
			}
			
			return false;
		}
	}
}