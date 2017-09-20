package azura.avalon.maze.canvas.old
{
	import azura.banshee.door.Door;
	import azura.banshee.door.RoomWithDoors;
	import azura.banshee.engine.MouseI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.ZforestOld;
	import azura.banshee.zebra.i.SwampI;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.zode.ZnodeRoot;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2d;
	import azura.common.collections.ZintBuffer;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	public class LayerZforestDragOld implements SwampI,MouseI
	{
		public var root:ZnodeRoot;
		public var zforest:ZforestNode;
		
		private var item:ZebraNode;
		
		private var gl:G2dLayer;
		
		private var downPos:Point;
		private var downGlobal:Point;
		
		public var onMove:Signal=new Signal(int,int);
		
		public function LayerZforestDragOld(gl:G2dLayer)
		{
			this.gl=gl;
			Stage3DRoot.singleton().addLayer(this);
		}
		
		public function init():void{
			//canvas
			var link:ZRnodeG2d=ZRnodeG2d.createNewRenderer();
			gl.node.addChild(link.node);
			root=new ZnodeRoot(link,Stage3DRoot.singleton().stage.stageWidth,
				Stage3DRoot.singleton().stage.stageHeight);
			
			//forest
			zforest=new ZforestNode(root);
		}
		
		public function get x():int{
			return root.xRoot;
		}
		
		public function get y():int{
			return root.yRoot;
		}
		
		public function enterFrame():void{
			root.enterFrame();
		}
		
		public function dispose():void{
			zforest.dispose();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function get mouse():MouseI{
			return this;
		}
		
		public function mouseDown(x:int,y:int):void{
			downPos=new Point(x,y);
			downGlobal=new Point(root.xRoot,root.yRoot);
		}
		
		public function mouseMove(x:int,y:int):void{
			if(downPos==null)
				return;
			
			var dx:Number=(downPos.x-x)/root.scaleLocal;
			var dy:Number=(downPos.y-y)/root.scaleLocal;
			
			x=downGlobal.x+dx;
			y=downGlobal.y+dy;
			
//			trace(x,y,this);
			root.lookAt(x,y);
			
			if(item!=null && zforest.zforest.base.isRoad(x,y)){
				item.move(x,y);
			}
			
			onMove.dispatch(x,y);
		}
		
		public function mouseUp(x:int,y:int):void{
			
		}
		
		public function get active():Boolean{
			return zforest.zforest!=null;
		}
		
		public function set mc5Scene(value:String):void{
			Gallerid.singleton().getData(value).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				
				var data:ZintBuffer=item.dataClone();
				data.uncompress();
				
				var zf:ZforestOld=new ZforestOld();
				zf.fromBytes(data);
				zforest.zforest=zf;
				
				lookAt(xCache,yCache);
			}
		}
		
		private var xCache:int,yCache:int;
		public function lookAt(x:int,y:int):void{
			if(zforest.zforest==null){
				xCache=x;
				yCache=y;
			}else
				root.lookAt(x,y);
		}
		
		private var _onDoorClick:Signal=new Signal(Door);
		
		public function get onDoorClick():Signal
		{
			return _onDoorClick;
		}
		
		public function showDoor(data:Door):void{
			var doorIcon:ZebraNode=new ZebraNode(zforest.assLayer);
			
			doorIcon.move(data.x,data.y);
			doorIcon.angle=data.pan;
			doorIcon.mc5=data.mc5;		
			
			//==================================== removed and waiting replace ============================
			//			var dc:DoorClicker=new DoorClicker();
			//			dc.door=data;
			//			dc.onDoorClick=onDoorClick;
			//			
			//			doorIcon.renderer.registerMouse(dc);
		}
		
		public function boot(rd:RoomWithDoors,x:int,y:int):void{
			mc5Scene=rd.room.mc5;
			lookAt(x,y);
			//			currentLayer.lookAt(x,y);
			for each(var d:Door in rd.doorList){
				showDoor(d);
			}
		}
		
		public function showWalker(zebra:Zebra):void{
			item=new ZebraNode(zforest.assLayer);
			item.data=zebra;
		}
		
		public function clear():void{
			root.clear();
		}
	}
}