package azura.banshee.mass.graphics.player
{
	import azura.banshee.mass.model.v3.MassTree3;
	import azura.banshee.mass.model.v3.MassTree3P;
	import azura.banshee.mass.sdk.MassCoderA4;
	import azura.banshee.zbox3.Zspace3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.engine.Zbox3ReplicaStarling;
	import azura.common.collections.ZintBuffer;
	
	import flash.display.Stage;
	
	import starling.display.Sprite;
	
	public class MassPlayerPanel2Canvas
	{
		public var space:Zspace3;
		public var uiLayer:Zbox3Container;
		
		public var tree:MassTree3;
		private var stage:Stage;
		
		public function MassPlayerPanel2Canvas()
		{
		}
		
		public function init(stage:Stage,root:Sprite):void
		{
			this.stage=stage;
			
			var replica:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(root);
			
			space=new Zspace3(replica);		
			space.look(0,0,stage.stageWidth,stage.stageHeight);
			
			uiLayer=new Zbox3Container(space);
			uiLayer.zbox.width=space.widthView;
			uiLayer.zbox.height=space.heightView;
		}
		
		public function resize(w:int,h:int):void{
			uiLayer.zbox.width=w;
			uiLayer.zbox.height=h;
		}
		
		public function showTree(data:ZintBuffer,sdk:MassCoderA4):void{
			//			var sr:ScreenResizer=new ScreenResizer(tree.ss.designWidth,tree.ss.designHeight);
			
			this.tree=new MassTree3P(uiLayer.zbox,sdk);
			tree.fromBytes(data);
			tree.showVisible();
			
			//			tree.ss.display(stage.stageWidth,stage.stageHeight);
			//			uiLayer.zbox.width=tree.ss.dragWidth;
			//			uiLayer.zbox.height=tree.ss.dragHeight;
			//			uiLayer.zbox.scaleLocal=tree.ss.scale;
			//			
			//			tree.root.setRootSize(uiLayer.zbox.width,uiLayer.zbox.height);
			
		}
	}
}