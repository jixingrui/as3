package azura.banshee.zebra.editor.zforest
{
	import azura.banshee.engine.Statics;
	
	import azura.banshee.zebra.editor.ztree.Ztree2;
	import azura.banshee.zebra.node.Bounder;
	import azura.banshee.zebra.node.ZebraNode;
	import azura.banshee.zbox2.Zspace2;
	import azura.banshee.zbox2.editor.EditorCanvas;
	import azura.banshee.zbox2.zebra.ZebraC2;
	import azura.banshee.zforest.Ztree;
	import azura.common.collections.ZintBuffer;
	import azura.touch.TouchBox;
	
	public class LayerZforestEditor2
	{
		public static var MouseDragScreen:int=0;
		public static var MouseDragItem:int=1;
		
//		private var gl:G2dLayer;
		
//		public var space:Zspace2;
		public var zforestNode:ZforestC2;
		
//		private var box:TouchBox;
//		public var moveScreen:MoveScreenG;
//		private var moveItem:MoveItemG;
		
		public var selectedItemIdx:int;
		
//		public function LayerZforestEditor2(gl:G2dLayer)
//		{
//			this.gl=gl;
//			Stage3DRoot.singleton().addLayer(this);
//			
//			box=new TouchBox();
//			box.box.width=Statics.stage.stageWidth;
//			box.box.height=Statics.stage.stageHeight;			
//			ZebraEditorShell.touchLayer.putBox(box);
//			
//			moveScreen=new MoveScreenG(this);
//			moveItem=new MoveItemG(this);
//			mouseMode=MouseDragScreen;
//		}
		
		public var ec:EditorCanvas;
		
		public function activate(ec:EditorCanvas):void
		{
			this.ec=ec;
			zforestNode=new ZforestC2(ec.space);
			//			mode=0;
//			base=new ZebraC2(ec.space.view);
//			actor=new ZebraC2(ec.space.view);
//			cross=new ZebraC2(ec.space.view);
//			base.sortValue=-1;
//			actor.sortValue=1;
//			cross.sortValue=2;
		}
		
		public function deactivate():void{
//			base.zbox.dispose();
//			actor.zbox.dispose();
//			cross.zbox.dispose();
		}
		
		public function get currentZtreeNode():ZebraC2{
			return zforestNode.ztreeList[selectedItemIdx];
		}
		
		public function focus(zp:Ztree2):void{
			currentZtreeNode.feed(zp.zebra);
//			currentZtreeNode.zbox.move(zp.zebra.x,zp.zebra.y);
			
//			ec.space.look(zp.zebra.x,zp.zebra.y);
		}
		
		public function moveZtree(x:int,y:int):void{
			currentZtreeNode.zbox.move(x,y);
			var current:Ztree2=zforest.ztreeList[selectedItemIdx];
//			current.zebra.x=x;
//			current.zebra.y=y;
		}
		
		public function loadZforest(data:ZintBuffer):void{
			clear();
			
			zforestNode.zforest.fromBytes(data);
			zforestNode.reload();
//			moveScreen.bounder=new Bounder(Statics.stage.stageWidth,Statics.stage.stageHeight,
//				zforest.land.boundingBox.width,zforest.land.boundingBox.height);
		}
		
		public function get zforest():Zforest2{
			return zforestNode.zforest;
		}
		
		public function jumpToHere():void{
//			ec.space.look(currentZtreeNode.xGlobal,currentZtreeNode.yGlobal);
		}
		
//		public function init(stage:Stage):void{
//			//canvas
////			var link:ZRnodeG2dOld=ZRnodeG2dOld.createNewRenderer();
////			gl.node.addChild(link.node);
//			
////			var scale:Number=1;
////			var w:Number=Stage3DRoot.singleton().stage.stageWidth/scale;
////			var h:Number=Stage3DRoot.singleton().stage.stageHeight/scale;
//			
//			space=new Zspace(link,w,h);
////			space.scaleLocal=scale;
//			
//			zforestNode=new ZforestNode2(space.view);
//		}
		
		public function set mouseMode(mode:int):void{
//			if(mode==MouseDragScreen){
//				box.addUser(moveScreen);
//			}else if(mode==MouseDragItem){
//				box.addUser(moveItem);
//			}
		}
		
//		public function enterFrame():void{
//			space.enterFrame();
//		}
		
//		public function dispose():void
//		{
//			box.dispose();
////			space.dispose();
//			Stage3DRoot.singleton().removeLayer(this);
//		}
		
		public function clear():void{
//			zforestNode.clear();
		}
		
	}
}