package azura.avalon.maze.canvas.player
{
	import azura.avalon.maze.data.Door;
	import azura.avalon.maze.data.EventCenter;
	import azura.avalon.maze.data.MazeOld;
	import azura.avalon.maze.data.RegionNode;
	import azura.avalon.maze.data.RoomShellOld;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.avalon.zbase.zway.WayDot45;
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.node.ZlineNode;
	import azura.banshee.zebra.zode.ZboxOld;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Zforest;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	
	public class LayerMazePlayer implements Stage3DLayerI
	{
		public static var MOUSEDRAGSCREEN:int=0;
		public static var MOUSEPATH:int=1;
		
		private var gl:G2dLayer;
		
		public var root:Zspace;
		public var zforestNode:ZforestNode;
		
//		private var mouse_:MouseDUMI;
//		[Bindable]
//		public var mousePath:MousePath;
		
		public var wayFinder:WayFinder;
		private var points:Vector.<ZboxOld>=new Vector.<ZboxOld>();
		
		private var this_:LayerMazePlayer;
		
		public var currentRoom:RoomShellOld;
		
		public var maze:MazeOld;
		
		public function LayerMazePlayer(gl:G2dLayer)
		{
			this.gl=gl;
			this_=this;
			
//			mouse_=new MouseDragScreen(this);
			Stage3DRoot.singleton().addLayer(this);			
//			mousePath=new MousePath(this);
			
			EventCenter.enterDoor_Door.add(showRoom);
		}		
		
		public function drawPoint(x:int,y:int,color:int,size:int=2):void{
			var dot:BitmapData=Draw.circle(size,color);
			var z:Zebra=new Zebra();
			var zb:Zbitmap=new Zbitmap();
			zb.bitmapData=dot;
			z.branch=zb;
			var zn:ZebraNode=new ZebraNode(zforestNode.headLayer);
			zn.zebra=z;
			zn.move(x,y);
			points.push(zn);
		}
		
		public function drawLine(xStart:int,yStart:int,xEnd:int,yEnd:int,color:int=0xffff0000,thick:int=2):void{
			var zn:ZlineNode=new ZlineNode(zforestNode.headLayer);
			zn.draw(color,thick);
			zn.moveLine(xStart,yStart,xEnd,yEnd);
			
			points.push(zn);
		}
		
		public function showRoom(door:Door):void{
			
			if(door.regionNode.room.data.mc5.length!=42){
				trace("empty map",this);				
				return;
			}
			
			currentRoom=door.regionNode.room;
			
			clear();
			
			Gallerid.singleton().getData(door.regionNode.room.data.mc5).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				
				var data:ZintBuffer=item.dataClone();
				data.uncompress();
				
				var zf:Zforest=new Zforest();
				zf.fromBytes(data);
				zforestNode.zforest=zf;
				
				wayFinder=new WayFinder(zf.way,zf.zbaseScale);
				
				for each(var d:Door in door.regionNode.room.doorList){
					showDoor(d);
				}
				
				root.lookAt(door.x,door.y);
				
				showPath();
			}
		}
		
		public function showPath():void{
			for each(var re:RegionNode in currentRoom.regionList){
				if(re.pathStart==null||re.pathEnd==null)
					continue;
				
				var sn:WayDot45=wayFinder.start(re.pathStart.x,re.pathStart.y);
				var en:WayDot45=wayFinder.end(re.pathEnd.x,re.pathEnd.y);
				if(sn==null||en==null){
					trace("point no good");
					return;
				}
				
				var path:Vector.<Point>=wayFinder.searchPath();			
				for(var i:int=0;i<path.length-1;i++){
					drawLine(path[i].x,path[i].y,path[i+1].x,path[i+1].y);
				}
//				var next:Point;
//				for each(next in path){
//					drawPoint(next.x,next.y,0xffff0000,4);
//				}
				
				drawPoint(re.pathStart.x,re.pathStart.y,0xff00ff00,4);
				drawPoint(re.pathEnd.x,re.pathEnd.y,0xff0000ff,4);
			}
		}
		
		private function showDoor(door:Door):void{
			Gallerid.singleton().getData(door.mc5).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				var data:ZintBuffer=item.dataClone();
				data.uncompress();
				
				var icon:ZebraNode=new ZebraNode(zforestNode.footLayer);
				var zebra:Zebra=new Zebra();
				zebra.fromBytes(data);
				icon.zebra=zebra;
//				icon.observer=door;
				
				icon.angle=door.pan;
				icon.move(door.x,door.y);
				icon.scaleLocal=currentRoom.data.scale/100*door.scale/100;
			}
		}
		
		public function init(stage:Stage):void{
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
			var scale:Number=Stage3DRoot.singleton().stage.stageWidth/1024;
			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
			
			root=new Zspace(link,w,h);
			root.scaleLocal=scale;
			
			zforestNode=new ZforestNode(root.root);
		}
		
//		public function get mouse():MouseDUMI{
//			return mouse_;
//		}		
		
		public function set mouseMode(mode:int):void{
//			if(mode==MOUSEDRAGSCREEN)
//				mouse_=new MouseDragScreen(this);
//			else if(mode==MOUSEPATH){
//				mouse_=mousePath;
//			}
		}
		
		public function clearPoints():void{
			while(points.length>0){
				var p:ZboxOld=points.pop();
				p.dispose();
			}
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
			clearPoints();
			zforestNode.clear();
		}
		
		public function get x():int{
			return root.xView;
		}
		
		public function get y():int{
			return root.yView;
		}
	}
}