package azura.banshee.engine.a3d
{
	import away3d.core.managers.Stage3DProxy;
	import away3d.loaders.parsers.Parsers;
	
	import flash.display.DisplayObjectContainer;
	
	public class A3dEngine
	{
		private static var instance:A3dEngine = new A3dEngine();	
		public function A3dEngine() {			
			if( instance ) throw new Error( "Singleton and can only be accessed through Singleton.getInstance()" );
		}		
		public static function singleton():A3dEngine {			
			return instance;			
		}	
		
		private var holder:DisplayObjectContainer;
		private var proxy:Stage3DProxy;
		
		private var _singleLayer:A3dLayer;
		public function get singleLayer():A3dLayer
		{
			return _singleLayer;
		}
		
		public function init(holder:DisplayObjectContainer,proxy:Stage3DProxy):void{
			this.holder=holder;			
			this.proxy=proxy;
			
//			trace("parsers enabled",this);
			Parsers.enableAllBundled();
			
			_singleLayer=new A3dLayer(proxy);
			holder.addChild(_singleLayer.view);
		}
	}
}