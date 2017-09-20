package azura.avalon.maze3.ui
{
	import azura.avalon.maze.data.EventCenter;
	import azura.avalon.maze.data.Item;
	import azura.avalon.maze3.data.Mdoor;
	import azura.avalon.maze3.data.Mroom;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.avalon.zbase.zway.WayFinder;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Zforest;
	import azura.touch.mouserOld.MouserDrag;
	
	import flash.display.Stage;
	
	public class LayerMaze3DoorEdit implements Stage3DLayerI
	{
		public static var MOUSEDRAGSCREEN:int=0;
		public static var MOUSEDRAGDOOR:int=1;
		
		private var gl:G2dLayer;
		
		internal var root:Zspace;
		public var zforestNode:ZforestNode;
		
		public var idxSelectedDoor:int=-1;
		public var door:Mdoor;
		private var doorNodeList:Vector.<ZebraNode>=new Vector.<ZebraNode>();
		
		private var this_:LayerMaze3DoorEdit;
		
		public var wayFinder:WayFinder;
		
		private var room:Mroom;
		
		public var stage:Stage;
		
		private var md:MouserDrag;
		
		
		public var panel:Maze3DoorEditPanel;
		
		public function LayerMaze3DoorEdit(gl:G2dLayer,stage:Stage)
		{
			this.gl=gl;
			this.stage=stage;
			this_=this;
			
			md=new MouserDrag(stage);
			
			mouseMode=MOUSEDRAGSCREEN;
			Stage3DRoot.singleton().addLayer(this);
			
			EventCenter.moveItem.add(moveDoor);
			function moveDoor():void{
				mouseMode=MOUSEDRAGDOOR;
			}
			
			EventCenter.lookAt.add(root.lookAt);
		}
		
		public function get selectedDoorNode():ZebraNode{
			return doorNodeList[idxSelectedDoor];
		}
		
		public function rotateItem(angle:int):void{
			selectedDoorNode.angle=angle;
			panel.doorPanel.door.zebra.angle=angle;
			panel.drDoor.save();
		}
		
		public function showDoor(item:Mdoor):void{
			var dn:ZebraNode=doorNodeList[idxSelectedDoor];
			dn.zebra=item.zebra;
			dn.move(item.zebra.x,item.zebra.y);
			dn.angle=item.zebra.angle;
		}
		
		public function loadZforest(zf:Zforest):void{
			clearDoor();
			zforestNode.zforest=zf;
			zforestNode.reload();
			lookAt(xCache,yCache);
			
			wayFinder=new WayFinder(zf.way,zf.zbaseScale);
		}
		
		public function loadDoor(doorList:Vector.<Mdoor>):void{
			clearDoor();
			for each(var d:Mdoor in doorList){
				var dn:ZebraNode=new ZebraNode(zforestNode.footLayer);
				doorNodeList.push(dn);
				dn.zebra=d.zebra;
				dn.move(d.zebra.x,d.zebra.y);
				dn.angle=d.zebra.angle;
			}
		}
		
		private var xCache:int,yCache:int;
		public function lookAt(x:int,y:int):void{
			if(zforestNode.zforest==null){
				xCache=x;
				yCache=y;
			}else
				root.lookAt(x,y);
		}
		
		public function init(stage:Stage):void{
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
			var scale:Number=1;
			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
			
			root=new Zspace(link,w,h);
			root.scaleLocal=scale;
			
			zforestNode=new ZforestNode(root.root);
		}
		
		public function set mouseMode(mode:int):void{
			if(mode==MOUSEDRAGSCREEN){
				md.listener=new MouseDragScreen(this);
			}else if(mode==MOUSEDRAGDOOR){
				md.listener=new MouseDragDoor(this);
			}
		}
		
		public function enterFrame():void{
			root.enterFrame();
		}
		
		public function dispose():void
		{
			clearDoor();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clearDoor():void{
			for each(var dn:ZebraNode in doorNodeList){
				dn.dispose();
			}
			doorNodeList=new Vector.<ZebraNode>();
		}
		
		public function clear():void{
			clearDoor();
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