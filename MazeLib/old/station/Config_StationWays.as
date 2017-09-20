package assets.station
{
	import azura.common.algorithm.crypto.MC5;
	import azura.common.algorithm.crypto.Stega;
	import azura.common.sound.VoiceConfigI;
	import azura.fractale.FrackConfigI;
	import azura.fractale.algorithm.HintBook;
	import azura.gallerid3.i.Mc5ConfigI;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.XMLListCollection;
	import mx.core.BitmapAsset;
	
	import org.osflash.signals.Signal;
	
	public class Config_StationWays
	{
		private var xml:XML;
		private var _onReady:Signal=new Signal();
		
		public function Config_StationWays(url:String="assets/station/config_station.xml")
		{
			var loader: URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, handleCompleted);
			
			function handleCompleted(event: Event): void
			{
				var loader: URLLoader=event.target as URLLoader; 
				xml = XML(loader.data);
				onReady.dispatch();
			}	
		}	
		
		public function get onReady():Signal
		{
			return _onReady;
		}
		
		public function get maze():String{
			return xml.maze;
		}
		
		public function get pack():String{
			return xml.pack;
		}
		
		public function get foot():String{
			return xml.foot;
		}
		
		public function get floors():XMLList{
			return xml.floors[0].floor;
		}
		
//		public function listOfFloor(idx:int):IList{
//			var data:XMLList=floors.location[idx].loc;
//			return new XMLListCollection(data);
//		}
		
//		public function get list():IList{
//			var data:XMLList=xml.location[0].loc;
//			return new XMLListCollection(data);
////			var ar:ArrayCollection=new ArrayCollection(new XMLListCollection(data).to
//		}
	}
}