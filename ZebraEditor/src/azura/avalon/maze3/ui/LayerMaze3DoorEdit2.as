package azura.avalon.maze3.ui
{
	import azura.avalon.maze.data.EventCenter;
	import azura.avalon.maze3.data.Mdoor2;
	import azura.avalon.maze3.data.Mroom;
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.starling_away.StarlingLayer;
	import azura.banshee.zbox2.Zspace2;
	import azura.banshee.zbox2.engine.starling.Zbox2ReplicaStarling;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.banshee.zebra.editor.zforest.Zforest2;
	import azura.banshee.zebra.editor.zforest.ZforestC2;
	import azura.touch.mouserOld.MouserDrag;
	
	import flash.display.Stage;
	
	public class LayerMaze3DoorEdit2 implements Stage3DLayerI
	{
		public static var MOUSEDRAGSCREEN:int=0;
		public static var MOUSEDRAGDOOR:int=1;
		
//		private var gl:G2dLayer;
		
		internal var space:Zspace2;
		public var zforestNode:ZforestC2;
//		public var bg:ZebraC2;
		
		public var idxSelectedDoor:int=-1;
		public var door:Mdoor2;
		private var doorNodeList:Vector.<ZebraC2>=new Vector.<ZebraC2>();
		
		private var this_:LayerMaze3DoorEdit2;
		
		public var wayFinder:WayFinder;
		
		private var room:Mroom;
		
		public var stage:Stage;
		
		private var md:MouserDrag;
		private var sl:StarlingLayer;
		
		public var panel:Maze3DoorEditPanel;
		
		public function LayerMaze3DoorEdit2(sl:StarlingLayer,stage:Stage)
		{
//			this.gl=gl;
			this.sl=sl;
			this.stage=stage;
			this_=this;
			
			md=new MouserDrag(stage);
			
			mouseMode=MOUSEDRAGSCREEN;
			Stage3DRoot.singleton().addLayer(this);
			
			EventCenter.moveItem.add(moveDoor);
			function moveDoor():void{
				mouseMode=MOUSEDRAGDOOR;
			}
			
			
//			EventCenter.lookAt.add(space.lookAt);
		}
		
		public function init(stage:Stage):void{
			var rep:Zbox2ReplicaStarling=new Zbox2ReplicaStarling(sl.root);
			space.viewSizeScaled(stage.stageWidth,stage.stageHeight);
			space.look(x,y);
			zforestNode=new ZforestC2(space);
			
		}
		
		public function enterFrame():void{
//			if(root!=null)
//				root.enterFrame();
		}
		
		public function get selectedDoorNode():ZebraC2{
			return doorNodeList[idxSelectedDoor];
		}
		
		public function rotateItem(angle:int):void{
			selectedDoorNode.zbox.angleLocal=angle;
//			panel.doorPanel.door.zebra.angle=angle;
			panel.drDoor.save();
		}
		
		public function showDoor(item:Mdoor2):void{
			var dn:ZebraC2=doorNodeList[idxSelectedDoor];
			dn.feed(item.zebra);
//			dn.zbox.move(item.zebra.x,item.zebra.y);
//			dn.zbox.angleLocal=item.zebra.angle;
		}
		
		public function loadZforest(zf:Zforest2):void{
			clearDoor();
			zforestNode.zforest=zf;
			zforestNode.reload();
			lookAt(xCache,yCache);
			
			wayFinder=new WayFinder(zf.way,zf.zbaseScale);
		}
		
		public function loadDoor(doorList:Vector.<Mdoor2>):void{
			clearDoor();
			for each(var d:Mdoor2 in doorList){
				var dn:ZebraC2=new ZebraC2(zforestNode.footLayer.zbox);
				doorNodeList.push(dn);
				dn.feed(d.zebra);
//				dn.zbox.move(d.zebra.x,d.zebra.y);
//				dn.zbox.angle=d.zebra.angle;
			}
		}
		
		private var xCache:int,yCache:int;
		public function lookAt(x:int,y:int):void{
			if(zforestNode.zforest==null){
				xCache=x;
				yCache=y;
			}else
				space.look(x,y);
		}
		
//		public function init(stage:Stage):void{
//			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
//			gl.node.addChild(link.node);
//			
//			var scale:Number=1;
//			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
//			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
//			
//			space=new Zspace(link,w,h);
//			space.scaleLocal=scale;
//			
//			zforestNode=new ZforestNode(space.space);
//		}
		
		public function set mouseMode(mode:int):void{
			if(mode==MOUSEDRAGSCREEN){
//				md.listener=new MouseDragScreen(this);
			}else if(mode==MOUSEDRAGDOOR){
//				md.listener=new MouseDragDoor(this);
			}
		}
		
//		public function enterFrame():void{
//			space.enterFrame();
//		}
		
		public function dispose():void
		{
			clearDoor();
//			space.dispose();
//			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clearDoor():void{
			for each(var dn:ZebraC2 in doorNodeList){
				dn.zbox.dispose();
			}
			doorNodeList=new Vector.<ZebraC2>();
		}
		
		public function clear():void{
//			clearDoor();
//			zforestNode.clear();
		}
		
		public function get x():int{
			return space.viewX;
		}
		
		public function get y():int{
			return space.viewY;
		}
	}
}