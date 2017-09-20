package azura.banshee.engine.starling_away
{
	import away3d.core.managers.Stage3DProxy;
	
	import flash.display.DisplayObjectContainer;
	
	import starling.display.Sprite;
	
	public class StarlingEngine extends Sprite
	{
		private static var instance:StarlingEngine = new StarlingEngine();	
		public function StarlingEngine() {			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" );
		}		
		public static function singleton():StarlingEngine {			
			return instance;			
		}	
		
		private var holder:DisplayObjectContainer;
		private var proxy:Stage3DProxy;
		
		private var _singleLayer:StarlingLayer;
		public function get singleLayer():StarlingLayer
		{
			return _singleLayer;
		}
		
		public function init(holder:DisplayObjectContainer,proxy:Stage3DProxy):void{
			this.holder=holder;			
			this.proxy=proxy;
			_singleLayer=new StarlingLayer();
		}
	}
}