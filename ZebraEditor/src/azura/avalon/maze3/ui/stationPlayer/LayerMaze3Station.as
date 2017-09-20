package azura.avalon.maze3.ui.stationPlayer
{
	import azura.avalon.maze.data.Dump;
	import azura.avalon.maze3.data.Helix;
	import azura.avalon.maze3.data.Mdoor;
	import azura.avalon.maze3.data.Mwoo;
	import azura.avalon.maze3.data.RoomShell;
	import azura.avalon.maze3.ui.seeker.TreeCar;
	import azura.avalon.maze3.ui.seeker.TreeTrain;
	import azura.avalon.maze3.ui.woo.WooObserver;
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Zforest;
	import azura.common.collections.ZintBuffer;
	import azura.common.ui.grid.GridMotor;
	import azura.touch.mouserOld.MouserDrag;
	import azura.gallerid4.Gal4;
	
	import flash.display.Stage;
	
	public class LayerMaze3Station implements Stage3DLayerI
	{
		public static var MOUSEDRAGSCREEN:int=0;
		public static var MOUSEDRAGWOO:int=1;
		
		public static var instance:LayerMaze3Station;
		
		private var gl:G2dLayer;
		
		internal var rootGround:Zspace;
		public var zforestNode:ZforestNode;
		
		internal var rootHud:Zspace;
		
		private var doorNodeList:Vector.<ZebraNode>=new Vector.<ZebraNode>();
		
		public var idxSelectedWoo:int=-1;
		public var woo:Mwoo;
		private var wooNodeList:Vector.<ZebraNode>=new Vector.<ZebraNode>();
		
		private var this_:LayerMaze3Station;
		
		private var room:RoomShell;
		
		public var stage:Stage;
		
		private var md:MouserDrag;
		
		public var dump:Dump=new Dump();
		
		public var gridMotorList:GridMotor;
		public var listPlayer:ClassifyListDisplay;

		public var gridMotorGrid:GridMotor;
		public var gridPlayer:ClassifyGridDisplay;
		
		public function LayerMaze3Station(gl:G2dLayer,stage:Stage)
		{
			this.gl=gl;
			this.stage=stage;
			this_=this;
			
			instance=this;
			Stage3DRoot.singleton().addLayer(this);
			
//			md.listener=new MouseDragScreen(this);
			
		}
		
		public var train:TreeTrain;
		public function showHelix(train:TreeTrain):void{
			this.train=train;
			var rootCar:TreeCar=train.getCar(train.idRoot);
			var helixRoot:Helix=rootCar.passenger as Helix;
			
			var zb:ZintBuffer=Gal4.readSync(helixRoot.listIcon);
			zb.uncompress();
			var zebra:Zebra=new Zebra();
			zebra.fromBytes(zb);
			
			
			listPlayer=new ClassifyListDisplay(this);
			
			listPlayer.znode=new ZebraNode(rootHud.root);
			var zi:ZebraIcon=new ZebraIcon();
			zi.zn=new ZebraNode(listPlayer.znode);
			zi.zn.zebra=zebra;
			
			gridMotorList=new GridMotor(listPlayer,300,600,200,100,true);
			
			md=new MouserDrag(stage);
			md.listener=listPlayer;
			
			gridMotorList.addItem(zi);
		}
		
		public function reload():void{
			room=dump.maze.uidToRoom(dump.eyeRoomUID);
			
			goTo(room,dump.eyeX,dump.eyeY);
		}
		
		public function goTo(room:RoomShell,x:int,y:int):void{
			this.room=room;
			var data:ZintBuffer=Gal4.readSync(room.room.me5Zforest);
			data.uncompress();
			var zf:Zforest=new Zforest();
			zf.fromBytes(data);
			loadZforest(zf);
			rootGround.lookAt(x,y);
			
			loadDoor(room.doorList);
			loadWoo(room.wooList);
		}
		
		public function loadZforest(zf:Zforest):void{
			clearWoo();
			clearDoor();
			zforestNode.zforest=zf;
			zforestNode.reload();
		}
		
		public function loadDoor(doorList:Vector.<Mdoor>):void{
			clearDoor();
			for each(var d:Mdoor in doorList){
				var dn:ZebraNode=new ZebraNode(zforestNode.footLayer);
				doorNodeList.push(dn);
				dn.zebra=d.zebra;
				dn.move(d.zebra.x,d.zebra.y);
				dn.angle=d.zebra.angle;
				
//				dn.observer=new DoorObserver(d,this);
			}
		}
		
		public function toDoor(uid:String):void{
			var door:Mdoor=dump.maze.uidToDoor(uid);
			goTo(door.room,door.zebra.x,door.zebra.y);
		}
		
		public function loadWoo(wooList:Vector.<Mwoo>):void{
			clearWoo();
			for each(var d:Mwoo in wooList){
				var dn:ZebraNode=new ZebraNode(zforestNode.footLayer);
				wooNodeList.push(dn);
				dn.zebra=d.icon;
				dn.move(d.icon.x,d.icon.y);
				dn.angle=d.icon.angle;
				
//				dn.observer=new WooObserver(d,dn);
			}
		}
				
		public function init(stage:Stage):void{
			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(link.node);
			
			var scale:Number=1;
			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
			
			rootGround=new Zspace(link,w,h);
			rootGround.scaleLocal=scale;
			
			zforestNode=new ZforestNode(rootGround.root);
			
			var l2:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
			gl.node.addChild(l2.node);
			
			rootHud=new Zspace(l2,w,h);
			rootHud.scaleLocal=scale;
		}
		
		public function enterFrame():void{
			rootHud.enterFrame();
			rootGround.enterFrame();
		}
		
		public function dispose():void
		{
			clearWoo();
			clearDoor();
			rootGround.dispose();
			rootHud.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clearWoo():void{
			for each(var dn:ZebraNode in wooNodeList){
				dn.dispose();
			}
			wooNodeList=new Vector.<ZebraNode>();
		}
		
		public function clearDoor():void{
			for each(var dn:ZebraNode in doorNodeList){
				dn.dispose();
			}
			doorNodeList=new Vector.<ZebraNode>();
		}
		
		public function clear():void{
			clearWoo();
			clearDoor();
			zforestNode.clear();
		}
	}
}