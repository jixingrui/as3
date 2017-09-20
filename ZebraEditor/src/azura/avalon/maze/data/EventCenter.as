package azura.avalon.maze.data
{
	import azura.banshee.zforest.Zforest;
	
	import org.osflash.signals.Signal;

	public class EventCenter
	{
//		public static var showMap_Zforest:Signal=new Signal(Zforest);
//		public static var clearMap:Signal=new Signal();
//		public static var showMap_mc5:Signal=new Signal(Room2D);
		
		
		public static var showItem:Signal=new Signal(Item);
		public static var moveItem:Signal=new Signal();
//		public static var saveDoor:Signal=new Signal();
		public static var saveItem:Signal=new Signal(Item);
		public static var lookAt:Signal=new Signal(int,int);
		
		public static var itemZebraLoaded:Signal=new Signal();
		
		public static var enterDoor_Door:Signal=new Signal(Door);
		
		public static var enterDoor_String:Signal=new Signal(String);
		
		public static var zforestLoaded:Signal=new Signal();
	}
}