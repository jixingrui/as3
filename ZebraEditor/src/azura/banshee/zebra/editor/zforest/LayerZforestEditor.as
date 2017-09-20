package azura.banshee.zebra.editor.zforest
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.engine.Stage3DLayerI;
	import azura.banshee.engine.Stage3DRoot;
	import azura.banshee.engine.g2d.G2dLayer;
	import azura.banshee.zebra.Zbitmap;
	import azura.banshee.zebra.Zebra;
	import azura.banshee.zebra.editor.ZebraEditorShell;
	import azura.banshee.zebra.node.Bounder;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zebra.node.ZforestNode;
	import azura.banshee.zebra.zode.Zspace;
	import azura.banshee.zebra.zode.g2d.ZRnodeG2dOld;
	import azura.banshee.zforest.Zforest;
	import azura.banshee.zforest.Ztree;
	import azura.common.collections.ZintBuffer;
	import azura.common.graphics.Draw;
	import azura.touch.watcherOld.WatcherEvent;
	import azura.touch.mouserOld.MouserDrag;
	import azura.touch.TouchBox;
	
	import flash.display.BitmapData;
	import flash.display.Stage;
	
	public class LayerZforestEditor implements Stage3DLayerI
	{
		public static var MouseDragScreen:int=0;
		public static var MouseDragItem:int=1;
		
		private var gl:G2dLayer;
		
		public var root:Zspace;
		public var zforestNode:ZforestNode;
		
		private var box:TouchBox;
		public var moveScreen:MoveScreenG;
		private var moveItem:MoveItemG;
		
		public var selectedItemIdx:int;
		
		public function LayerZforestEditor(gl:G2dLayer)
		{
			this.gl=gl;
			Stage3DRoot.singleton().addLayer(this);
			
//			box=new TouchBox();
//			box.box.width=Statics.stage.stageWidth;
//			box.box.height=Statics.stage.stageHeight;			
//			ZebraEditorShell.touchLayer.putBox(box);
			
			moveScreen=new MoveScreenG(this);
			moveItem=new MoveItemG(this);
			mouseMode=MouseDragScreen;
		}
		
		public function get currentZtreeNode():ZebraNode{
			return zforestNode.ztreeList[selectedItemIdx];
		}
		
		public function focus(zp:Ztree):void{
			currentZtreeNode.zebra=zp.zebra;
			currentZtreeNode.move(zp.zebra.x,zp.zebra.y);
			
			root.lookAt(zp.zebra.x,zp.zebra.y);
		}
		
		public function moveZtree(x:int,y:int):void{
			currentZtreeNode.move(x,y);
			var current:Ztree=zforest.ztreeList[selectedItemIdx];
			current.zebra.x=x;
			current.zebra.y=y;
		}
		
		public function loadZforest(data:ZintBuffer):void{
			clear();
			
			zforestNode.zforest.fromBytes(data);
			zforestNode.reload();
			moveScreen.bounder=new Bounder(Statics.stage.stageWidth,Statics.stage.stageHeight,
				zforest.land.boundingBox.width,zforest.land.boundingBox.height);
		}
		
		public function get zforest():Zforest{
			return zforestNode.zforest;
		}
		
		public function jumpToHere():void{
			root.lookAt(currentZtreeNode.xGlobal,currentZtreeNode.yGlobal);
		}
		
		public function init(stage:Stage):void{
			//canvas
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
			if(mode==MouseDragScreen){
				box.addUser(moveScreen);
			}else if(mode==MouseDragItem){
				box.addUser(moveItem);
			}
		}
		
		public function enterFrame():void{
			root.enterFrame();
		}
		
		public function dispose():void
		{
			box.dispose();
			root.dispose();
			Stage3DRoot.singleton().removeLayer(this);
		}
		
		public function clear():void{
			zforestNode.clear();
		}
		
	}
}