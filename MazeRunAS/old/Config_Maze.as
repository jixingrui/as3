package assets
{
	import azura.common.algorithm.crypto.Stega;
	import azura.common.collections.ZintBuffer;
	import azura.common.loaders.FileLoader;
	import azura.common.util.Fork;
	import azura.fractale.FrackConfigI;
	import azura.fractale.algorithm.HintBook;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.core.BitmapAsset;
	
	import org.osflash.signals.Signal;
	
	public class Config_Maze
	{
		
		private var xml:XML;
		
		public var onReady:Signal=new Signal();
		
		public function Config_Maze(url:String="assets/config.xml")
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
		
		//================== data =============
		
		public function get maze():String{
			return xml.mazeRun.maze;
		}
		
		public function get karma():String{
			return xml.mazeRun.karma;
		}
		
		public function get pc():String{
			return xml.mazeRun.pc;
		}
		
		public function get speed():int{
			return xml.mazeRun.speed;
		}
	}
}