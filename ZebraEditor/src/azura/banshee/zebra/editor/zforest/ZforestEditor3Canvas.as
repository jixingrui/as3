package azura.banshee.zebra.editor.zforest
{
	import azura.banshee.zbox3.editor.EditorCanvas3;
	import azura.banshee.zbox3.zebra.ZebraC3;
	import azura.banshee.zebra.editor.ztree.Ztree3;
	import azura.common.collections.ZintBuffer;
	
	public class ZforestEditor3Canvas
	{
//		public static var MouseDragScreen:int=0;
//		public static var MouseDragItem:int=1;
		
		public var zforestNode:ZforestC3;
		
//		private var selectedItemIdx:int;
		
		public var ec:EditorCanvas3;
		
		private var moveItem:MoveItemG3;
		private var moveScreen:MoveScreenG3;
		
		public function activate(ec:EditorCanvas3):void
		{
			this.ec=ec;
			zforestNode=new ZforestC3(ec.space);
			moveScreen=new MoveScreenG3(this);
//			zforestNode.zbox.addGesture(moveScreen);
			
			moveItem=new MoveItemG3(this);
		}
		
		public function deactivate():void{
			zforestNode.zbox.dispose();
		}
		
		public function select(idx:int):void{
			if(zforestNode.selectedZtree!=null){
				zforestNode.selectedZtree.zbox.removeGestureAll();
			}
			zforestNode.select(idx);
			zforestNode.selectedZtree.zbox.addGesture(moveItem);
		}
		
//		public function selecte
		
//		public function insert():Ztree3{
////			var zt:Ztree3=new Ztree3();
//			return zforestNode.insert();
//		}
		
//		public function get currentZtreeNode():ZebraC3{
//			return zforestNode.ztreeList[selectedItemIdx];
//		}
		
//		public function focus(zp:Ztree3):void{
//			currentZtreeNode.feedZebra(zp.zebra);
//		}
		
		public function moveZtree(x:int,y:int):void{
			zforestNode.selectedZtree.zbox.move(x,y);
//			currentZtreeNode.zbox.move(x,y);
//			var current:Ztree3=zforest.ztreeList[selectedItemIdx];
			//			current.zebra.x=x;
			//			current.zebra.y=y;
		}
		
		public function loadZforest(data:ZintBuffer):void{
			//			clear();
			
			zforestNode.zforest.fromBytes(data);
			zforestNode.reload();
			//			moveScreen.bounder=new Bounder(Statics.stage.stageWidth,Statics.stage.stageHeight,
			//				zforest.land.boundingBox.width,zforest.land.boundingBox.height);
		}
		
		public function get zforest():Zforest3{
			return zforestNode.zforest;
		}
		
		public function jumpToHere():void{
			//			ec.space.look(currentZtreeNode.xGlobal,currentZtreeNode.yGlobal);
		}
		
		//		public function set mouseMode(mode:int):void{
		//			if(mode==MouseDragScreen){
		////				zforestNode.selectedZtree.zbox.addGesture(moveScreen);
		//			}else if(mode==MouseDragItem){
		//				zforestNode.selectedZtree.zbox.addGesture(moveItem);
		//			}
		//		}
		
	}
}