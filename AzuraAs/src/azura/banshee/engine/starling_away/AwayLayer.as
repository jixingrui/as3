package azura.banshee.engine.starling_away
{
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DProxy;
	
	import flash.display.DisplayObjectContainer;
	
	import org.osflash.signals.Signal;
	
	public class AwayLayer implements Stage3DLayerI2
	{
		public var view:View3D;		
		public var onEnterFrame:Signal=new Signal();
		
		public function init(proxy:Stage3DProxy,holder:DisplayObjectContainer):void
		{
			view = new View3D();
			view.antiAlias=4;
			view.stage3DProxy=proxy;
			view.shareContext=true;
			view.rightClickMenuEnabled=false;
			holder.addChild(view);
		}
		
		public function resize(width:int, height:int):void{
			view.width=width;
			view.height=height;
		}
		
		public function enterFrame():void{
			onEnterFrame.dispatch();
			view.render();
		}
		
		public function clear():void
		{
		}
		
		public function dispose():void
		{
			view.dispose();
		}
	}
}