package floor
{
	import a.Statics;
	
	import azura.banshee.editors.zforest.Zforest;
	import azura.banshee.editors.zforest.way.WayFinder;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zbase.WayDot45;
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.node.Bounder;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.node.ZlineNode;
	import azura.banshee.zebra.zode.Znode;
	import azura.banshee.zebra.zode.ZnodeRoot;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2d;
	import azura.common.algorithm.FastMath;
	import azura.common.algorithm.pathfinding.astar2.AStar;
	import azura.common.algorithm.pathfinding.astar2.AStarI;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	import azura.gallerid3.GalMail;
	import azura.gallerid3.Gallerid;
	import azura.gallerid3.source.GsBytes;
	import azura.avalon.maze.data.Door;
	import azura.avalon.maze.data.Item;
	import azura.avalon.maze.data.Maze;
	import azura.avalon.maze.data.RegionNode;
	import azura.avalon.maze.data.RoomShell;
	
	import com.deadreckoned.assetmanager.AssetManager;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class LayerStationFloors implements Stage3DLayerI
	{
		public static var MOUSE_EXPLORE:int=0;
		public static var MOUSE_STARTPOS:int=1;
		
		private var gl:G2dLayer;
		
		public var root:ZnodeRoot;
		public var zforestNode:ZforestNode;
		
		public var mouseSP:MouseStartPos;
		public var mouseE:MouseExplore;
		
		private var points:Vector.<Znode>=new Vector.<Znode>();
		
		private var this_:LayerStationFloors;
		
		public var maze:Maze;
		public var currentRoom:RoomShell;
		public var currentDoor:Door;
		
		public var wfCurrent:WayFinder;
		public var startRegion:RegionNode,endRegion:RegionNode;
		public var startNode:WayDot45,endNode:WayDot45;
		public var startPoint:Point=new Point();
		
		private var url_Zebra:Dictionary=new Dictionary();
		
		public function LayerStationFloors(gl:G2dLayer,stage:Stage)
		{
			this.gl=gl;
			this_=this;
			
			Stage3DRoot.singleton().addLayer(this);			
			
			mouseMode=MOUSE_STARTPOS;
		}		
		
		public function zoom(scaleX:Number,scaleY:Number):void{
			root.scaleLocal*=Math.sqrt(scaleX*scaleY);
		}
		
		private function urlToZebra(url:String):Zebra{
			var zebra:Zebra=url_Zebra[url];
			if(zebra==null){
				var mc5:String=GsBytes.fromBytes(AssetManager.getInstance().get(url).asset);
				var data:ZintBuffer=Gallerid.singleton().mem.getData(mc5);
				data.uncompress();
				zebra=new Zebra();
				zebra.fromBytes(data);
				url_Zebra[url]=zebra;
			}
			return zebra;
		}
		
		public function drawPoint(x:int,y:int,color:int,size:int=2,head_foot:Boolean=true):void{
			var dot:BitmapData=Draw.circle(size,color);
			var z:Zebra=new Zebra();
			var zb:Zbitmap=new Zbitmap();
			zb.bitmapData=dot;
			z.branch=zb;
			var zn:ZebraNode;
			if(head_foot){
				zn=new ZebraNode(zforestNode.headLayer);
			}else{
				zn=new ZebraNode(zforestNode.footLayer);
			}
			zn.zebra=z;
			zn.move(x,y);
			points.push(zn);
		}
		
		public function drawArrow(url:String,xStart:int,yStart:int,xEnd:int,yEnd:int,color:int=0xffff0000):void{
			var icon:ZebraNode=new ZebraNode(zforestNode.assLayer);
			icon.zebra=urlToZebra(url);
			icon.angle=FastMath.xy2Angle(xEnd-xStart,yEnd-yStart);
			icon.scaleLocal=0.6;
			icon.move((xStart+xEnd)/2,(yStart+yEnd)/2);
			points.push(icon);
		}
		
		public function drawIcon(url:String,x:int,y:int):void{
			var icon:ZebraNode=new ZebraNode(zforestNode.assLayer);
			icon.zebra=urlToZebra(url);
			icon.move(x,y);
			points.push(icon);
		}
		
		public function drawLine(xStart:int,yStart:int,xEnd:int,yEnd:int,color:int=0xffff8800):void{
			
			var thick:int=4;
			var zn:ZlineNode=new ZlineNode(zforestNode.footLayer);
			zn.draw(color,thick);
			zn.moveLine(xStart,yStart,xEnd,yEnd);
			
			points.push(zn);
			
			drawPoint(xEnd,yEnd,color,2,false);
		}
		
		public function enterRoomByName(name:String,onLoaded:Function=null):void{
			currentRoom=maze.getRoom(name);
			clear();
			
			if(currentDoor!=null && currentDoor.regionNode.room!=currentRoom)
				currentDoor=null;
			
			Gallerid.singleton().getData(currentRoom.data.mc5).onReady.add(fileLoaded);
			function fileLoaded(item:GalMail):void{
				
				var data:ZintBuffer=item.dataClone();
				data.uncompress();
				
				var zf:Zforest=new Zforest();
				zf.fromBytes(data);
				zforestNode.zforest=zf;
				
				wfCurrent=new WayFinder(zf.zway,zf.zbaseScale);
				
				for each(var i:Item in currentRoom.itemList){
					showItem(i);
				}
				
				if(currentDoor!=null){
					var bounder:Bounder=new Bounder(Statics.stage.stageWidth/root.scaleLocal
						,Statics.stage.stageHeight/root.scaleLocal
						,zf.zmi.land.boundingBox.width,zf.zmi.land.boundingBox.height);
					bounder.bound(currentDoor.x,currentDoor.y);
					root.lookAt(bounder.x,bounder.y);
				}
				
				if(onLoaded!=null)
					onLoaded.call();
			}
		}
		
		private function showItem(item:Item):void{
			Gallerid.singleton().getData(item.mc5).onReady.add(fileLoaded);
			function fileLoaded(gm:GalMail):void{
				var data:ZintBuffer=gm.dataClone();
				data.uncompress();
				
				var icon:ZebraNode=new ZebraNode(zforestNode.headLayer);
				var zebra:Zebra=new Zebra();
				zebra.fromBytes(data);
				icon.zebra=zebra;
				icon.observer=item;
				
				if(item is Door){
					points.push(icon);
				}
				
				if(item.reverse)
					icon.angle=item.pan+180;
				else
					icon.angle=item.pan;
				icon.move(item.x,item.y);
				icon.scaleLocal=currentRoom.data.scale/100*item.scale/100;
			}
		}
		
		public function init():void{
			var link:ZRnodeG2d=ZRnodeG2d.createNewRenderer();
			gl.node.addChild(link.node);
			
			root=new ZnodeRoot(link,Statics.stage.stageWidth,Statics.stage.stageHeight);
			root.scaleLocal=Statics.stage.stageWidth/1920;
			zforestNode=new ZforestNode(root);
		}
		
		public function set mouseMode(mode:int):void{
			if(mouseSP!=null){
				mouseSP.dispose();
				mouseSP=null;				
			}
			if(mouseE!=null){
				mouseE.dispose();
				mouseE=null;
			}
			
			if(mode==MOUSE_EXPLORE){
				mouseE=new MouseExplore(this);
				mouseE.imgWidth=zforestNode.zforest.zmi.land.boundingBox.width;
				mouseE.imgHeight=zforestNode.zforest.zmi.land.boundingBox.height;
			}else if(mode==MOUSE_STARTPOS){
				mouseSP=new MouseStartPos(this);
			}
		}
		
		public function start(xg:int,yg:int):void{
			startNode=wfCurrent.start(xg,yg);
			if(startNode==null){
				drawPoint(xg,yg,0xff888888,4);
				return;
			}
			
			maze.cleanPath();
			clearPoints();
			
			startPoint.x=xg;
			startPoint.y=yg;
			
			startRegion=currentRoom.regionList[startNode.group];
			
			startRegion.xMouse=xg;
			startRegion.yMouse=yg;
			startRegion.isTerminal=true;
			
			//			drawPoint(xg,yg,0xff00ff00,4);
			drawIcon("station/start.zebra",xg,yg);
			
			mouseMode=LayerStationFloors.MOUSE_EXPLORE;
		}
		
		public function end(item:Item):void{
			endRegion=item.regionNode;
			endRegion.xMouse=item.x;
			endRegion.yMouse=item.y;
			endRegion.isTerminal=true;
			
			if(currentRoom==startRegion.room){
				findWay();
			}else{
				enterRoomByName(startRegion.room.data.name,findWay);
			}
		}
		
		private function findWay():void{
			
			if(startRegion==endRegion){		
				endNode=wfCurrent.end(endRegion.xMouse,endRegion.yMouse);
				if(endNode==null){
					drawPoint(endRegion.xMouse,endRegion.yMouse,0xff888888,4);
					return;
				}
				maze.cleanPath();
				startRegion.pathStart=startPoint.clone();
				startRegion.pathEnd=new Point(endRegion.xMouse,endRegion.yMouse);
			}else{
				var pathRD:Vector.<AStarI>=AStar.search(startRegion,endRegion);
				if(pathRD==null){
					trace("path not found",this);
					return;
				}
				
				var str:String="path:";
				for each(var prd:AStarI in pathRD){
					str+=" "+prd;
				}
				trace(str,this);
				
				maze.cleanPath();
				
				startRegion.pathStart=startPoint.clone();
				var startDoor:Door=pathRD[0] as Door;
				startDoor.reverse=false;
				startRegion.pathEnd=new Point(startDoor.x,startDoor.y);
				startRegion.doorsToShow.push(startDoor);
				
				for(var i:int=1;i<pathRD.length-1;i++){
					var current:Door=pathRD[i] as Door;
					current.reverse=(i%2==1);
					current.regionNode.doorsToShow.push(current);
					
					var next:Door=pathRD[i+1] as Door;
					if(current.toDoor==next)
						continue;
					
					current.regionNode.pathStart=new Point(current.x,current.y);
					current.regionNode.pathEnd=new Point(next.x,next.y);
				}
				
				var endDoor:Door=pathRD[pathRD.length-1] as Door;
				endDoor.reverse=true;
				endRegion.pathStart=new Point(endDoor.x,endDoor.y);
				endRegion.pathEnd=new Point(endRegion.xMouse,endRegion.yMouse);
				endRegion.doorsToShow.push(endDoor);
			}
			
			showPath();
		}
		
		public function showPath():void{
			
			clearPoints();
			
			for each(var re:RegionNode in currentRoom.regionList){
				if(re.pathStart==null||re.pathEnd==null)
					continue;
				
				var sn:WayDot45=wfCurrent.start(re.pathStart.x,re.pathStart.y);
				var en:WayDot45=wfCurrent.end(re.pathEnd.x,re.pathEnd.y);
				if(sn==null||en==null){
					trace("point no good",this);
					return;
				}
				
				var path:Vector.<Point>=wfCurrent.searchPath();	
				if(path==null)
					return;
				
				var i:int;
				for(i=0;i<path.length-1;i++){
					drawLine(path[i].x,path[i].y,path[i+1].x,path[i+1].y);
				}
				
				var shrink:Vector.<Point>=new Vector.<Point>();
				var p1:Point=path[0];
				var p2:Point=path[1];
				var p3:Point;
				shrink.push(p1);
				var angle12:int=FastMath.xy2Angle(p1.x-p2.x,p1.y-p2.y);
				var angle13:int;
				for(i=2;i<=path.length-1;i++){
					p3=path[i];
					angle13=FastMath.xy2Angle(p1.x-p3.x,p1.y-p3.y);
					if(Math.abs(angle12-angle13)>2){
						p1=p2;
						p2=p3;
						shrink.push(p1);
						angle12=FastMath.xy2Angle(p1.x-p2.x,p1.y-p2.y);
					}else{
						p2=p3;
					}
				}
				shrink.push(path[path.length-1]);
				for(i=0;i<shrink.length-1;i++){
					var distLocal:int=FastMath.dist(shrink[i].x,shrink[i].y,shrink[i+1].x,shrink[i+1].y);					
					if(distLocal>100)
						drawArrow("station/arrow.zebra",shrink[i].x,shrink[i].y,shrink[i+1].x,shrink[i+1].y);
				}
				
				//				drawIcon("station/start.zebra",re.pathStart.x,re.pathStart.y);
				//				drawIcon("station/end.zebra",re.pathEnd.x,re.pathEnd.y);
				//				drawPoint(re.pathStart.x,re.pathStart.y,0xff00ff00,4);
				//				drawPoint(re.pathEnd.x,re.pathEnd.y,0xff0000ff,4);
				for each(var d:Door in re.doorsToShow){
					showItem(d);
				}
			}
			if(currentRoom==startRegion.room){
				drawIcon("station/start.zebra",startPoint.x,startPoint.y);
			}
			if(currentRoom==endRegion.room){
				drawIcon("station/end.zebra",endRegion.xMouse,endRegion.yMouse);
			}
		}
		
		private function wayToLocal(xg:int,yg:int):void{
			
			if(startPoint==null||startNode==null)
				return;
			
			endNode=wfCurrent.end(xg,yg);
			if(endNode==null){
				drawPoint(xg,yg,0xff888888,4);
				return;
			}
			
			endRegion=currentRoom.regionList[endNode.group];
			endRegion.xMouse=xg;
			endRegion.yMouse=yg;
			endRegion.isTerminal=true;
			
			drawPoint(xg,yg,0xff00ff00,4);
			
			clearPoints();
			
			if(endRegion==startRegion){
				maze.cleanPath();
				startRegion.pathStart=startPoint.clone();
				startRegion.pathEnd=new Point(xg,yg);
				showPath();
			}
		}
		
		public function clearPoints():void{
			while(points.length>0){
				var p:Znode=points.pop();
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
			return root.xRoot;
		}
		
		public function get y():int{
			return root.yRoot;
		}
	}
}