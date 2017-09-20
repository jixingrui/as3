package zexia.common
{
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.Statics;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.common.algorithm.FastMath;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid4.Gal4;
	import azura.gallerid4.GalPack4;
	import azura.touch.watcherOld.WatcherDrag;
	import azura.touch.watcherOld.WatcherEvent;
	
	import flash.display.Stage;
	import flash.filesystem.File;
	
	import org.osflash.signals.Signal;
	
	public class ZebraRotator implements Stage3DLayerI
	{
		private var gl:G2dLayer;
		
		public var root:Zspace;
		
		private var wd:WatcherDrag;
		
		public var onTurn:Signal=new Signal(int);
		
		public var angle:int=0;
		private var downAngle:Number=NaN;
		
		public var width:int,height:int;
		
		public function ZebraRotator(gl:G2dLayer,width:int,height:int)
		{
			this.gl=gl;
			this.width=width;
			this.height=height;
			Stage3DRoot.singleton().addLayer(this);
			
			wd=new WatcherDrag(Statics.stage);
			wd.addEventListener(WatcherEvent.DRAG_START,onDragStart);
			wd.addEventListener(WatcherEvent.DRAG_MOVE,onDragMove);
			wd.addEventListener(WatcherEvent.DRAG_END,onDragEnd);
		}
		
		public function init(stage:Stage):void{
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
//			root=new ZnodeRoot(link,Statics.stage.stageWidth,Statics.stage.stageHeight);
			root=new Zspace(link,width,height);
		}
		
		public function loadUrl(url:String):ZebraNode{
			var file:File=File.applicationDirectory.resolvePath(url);
			var master:String=new GalPack4().loadFrom(file);
			var data:ZintBuffer=Gal4.readSync(master);
			data.uncompress();
			var zn:ZebraNode=new ZebraNode(root.root);
			var z:Zebra=new Zebra();
			z.fromBytes(data);
			zn.zebra=z;		
			return zn;	
		}
		
		private var lastAngle:Number;
		public function onDragStart(we:WatcherEvent):void{
			downAngle=angle;
			lastAngle=angle;
		}
		
		public function onDragMove(we:WatcherEvent):void{
			if(isNaN(downAngle))
				return;
			
			var delta:Number=-we.delta.x/4;
			
			angle=downAngle+delta;
			if(Math.abs(lastAngle-angle)>70){
				onDragEnd(null);
				return;
			}
			
			lastAngle=angle;
			onTurn.dispatch(angle);
		}
		
		public function onDragEnd(we:WatcherEvent):void{
			downAngle=NaN;
		}
		
		public function enterFrame():void{
			root.enterFrame();
		}
		
		public function dispose():void
		{
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clear():void{
			root.clear();
		}
	}
}