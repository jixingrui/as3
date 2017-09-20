package azura.banshee.layers
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.door.Door;
	import azura.banshee.door.DoorWithDisplay;
	import azura.banshee.door.RoomWithDoors;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.mouse.MouseDUMI;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.i.ZmazeI;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.common.collections.ZintBuffer;
	import azura.touch.watcherOld.WatcherDrag;
	import azura.touch.watcherOld.WatcherEvent;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import flash.display.Stage;
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	public class LayerZimageDrag implements Stage3DLayerI
	{
		private var gl:G2dLayer;
		
		public var root:Zspace;
		public var bg:ZebraNode;
		public var doorLayer:ZboxOld;
		
		private var downScreen:Point;
		private var downRoot:Point;
		
//		private var scale:Number=1;
		
		private var wd:WatcherDrag;
		
		public function LayerZimageDrag(gl:G2dLayer)
		{
			this.gl=gl;
			Stage3DRoot.singleton().addLayer(this);
			
			wd=new WatcherDrag(Statics.stage);
			wd.addEventListener(WatcherEvent.DRAG_START,onDragStart);
			wd.addEventListener(WatcherEvent.DRAG_MOVE,onDragMove);
			wd.addEventListener(WatcherEvent.DRAG_END,onDragEnd);
		}
		
		public function init(stage:Stage):void{
			//canvas
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
			
//			var scale:Number=Stage3DRoot.singleton().stage.stageWidth/1280;
			var scale:Number=1;
			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
			
			root=new Zspace(link,w,h);
			root.scaleLocal=scale;
			
			bg=new ZebraNode(root.root);
			
			doorLayer=new ZboxOld(root.root);
		}
		
		public function get x():int{
			return root.xView;
		}
		
		public function get y():int{
			return root.yView;
		}
		
//		public function get mouse():MouseDUMI{
//			return this;
//		}
//		
//		public function get priority():int{
//			return 0;
//		}
		
		public function onDragStart(we:WatcherEvent):void{
			
			downScreen=new Point(we.position.x,we.position.y);
			downRoot=new Point(root.xView,root.yView);
//			trace("down",downScreen,this);
//			root.touch(root.xRoot+x/root.scaleLocal,root.yRoot+y/root.scaleLocal);
		}
		
		public function onDragMove(we:WatcherEvent):void{
			if(downScreen==null)
				return;
			
			var dx:Number=(downScreen.x-we.position.x)/root.root.scaleLocal;
			var dy:Number=(downScreen.y-we.position.y)/root.root.scaleLocal;			
//			var dx:Number=(downScreen.x-x);
//			var dy:Number=(downScreen.y-y);
			root.lookAt(downRoot.x+dx,downRoot.y+dy);
		}
		
		public function onDragEnd(we:WatcherEvent):void{
			downScreen=null;
		}
		
		public function enterFrame():void{
			root.enterFrame();
		}
		
		public function resize(width:int, height:int):void{
			
		}
		public function get active():Boolean{
			return bg.zebra!=null;
		}
		
		public function boot(rd:RoomWithDoors,x:int,y:int):void{
			mc5Scene=rd.room.mc5;
			lookAt(x,y);
			for each(var d:Door in rd.doorList){
				showDoor(d);
			}
		}
		
		public function set mc5Scene(value:String):void
		{
			Gallerid.singleton().getData(value).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				var data:ZintBuffer=item.dataClone();
				data.uncompress();
				
				var zebra:Zebra=new Zebra();
				zebra.fromBytes(data);
				
				if(zebra.type==Zebra.zimage)
					bg.zebra=zebra;
				else
					trace("LayerZimage: only zimage can be scene");
			}
		}
		
		public function lookAt(x:int,y:int):void{
			root.lookAt(x,y);
		}
		
		private var _onDoorClick:Signal=new Signal(Door);
		
		public function get onDoorClick():Signal
		{
			return _onDoorClick;
		}
		
		public function showDoor(data:Door):void{
//			var dwd:DoorWithDisplay=new DoorWithDisplay(this);
			
//			dwd.data=data;
//			dwd.icon=new ZebraNode(doorLayer);
//			
//			dwd.icon.move(data.x,data.y);
//			dwd.icon.angle=data.pan;
////			dwd.icon.dataLoaded.addOnce(onLoaded);
//			dwd.icon.mc5=data.mc5;
//			dwd.icon.observer=dwd;
//			function onLoaded(zn:ZebraNode):void{
//				zn.updateAABB(zn.boundingBox);
//			}
//			dwd.register();
		}
		
		public function dispose():void
		{
			doorLayer.dispose();
			bg.dispose();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clear():void{
			root.clear();
		}
	}
}