package azura.banshee.engine.starling_away
{
	import away3d.core.managers.Stage3DProxy;
	
	import flash.display.Stage;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class StarlingLayer implements Stage3DLayerI2
	{
		public var starling_:Starling;
		public var root:StarlingRoot;
		private var this_:StarlingLayer;
		
		public function StarlingLayer()
		{
			this_=this;
		}
		
		public function init(stage:Stage,proxy:Stage3DProxy,ready_StarlingLayer:Function):void
		{
//			Starling.handleLostContext=true;
			starling_=new Starling(StarlingRoot,stage,proxy.viewPort,proxy.stage3D);
//			starling_.showStatsAt("right","top");
			//			starling_.antiAliasing=16;
			starling_.skipUnchangedFrames=true;
			starling_.addEventListener(Event.ROOT_CREATED,onRootCreated);
			starling_.start();
			function onRootCreated(event:Event):void{
				root=starling_.root as StarlingRoot;
				resize(stage.stageWidth,stage.stageHeight);
				ready_StarlingLayer.call(null,this_);	
			}
		}
		
		public function enterFrame():void
		{
			starling_.nextFrame();
		}
		
		public function resize(width:int, height:int):void{
			if(starling_==null)
				return;
			
			starling_.viewPort.width=width;
			starling_.viewPort.height=height;
			starling_.stage.stageWidth=width;
			starling_.stage.stageHeight=height;
			
			root.x=Math.floor(width/2);
			root.y=Math.floor(height/2);
		}
		
		public function clear():void
		{
		}
		
		public function dispose():void
		{
			starling_.dispose();
		}
	}
}