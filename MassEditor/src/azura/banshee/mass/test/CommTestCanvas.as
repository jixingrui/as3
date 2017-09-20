package azura.banshee.mass.test
{
	import azura.banshee.mass.model.v3.MassTree3;
	import azura.banshee.mass.sdk.MassCoderA4;
	import azura.banshee.zbox3.Zspace3;
	import azura.banshee.zbox3.container.Zbox3Container;
	import azura.banshee.zbox3.engine.Zbox3ReplicaStarling;
	import azura.common.collections.ZintBuffer;
	
	import flash.display.Stage;
	
	import starling.display.Sprite;
	
	public class CommTestCanvas
	{
		public var stage:Stage;
		public var space:Zspace3;
		
		public var left:Zbox3Container;
		public var leftTreeView:MassTree3;
		
		public var right:Zbox3Container;
		public var rightTreeView:MassTree3;
		
		private var hub:CommDealer=new CommDealer();
		
		public function init(stage:Stage,root:Sprite):void
		{
			this.stage=stage;
			
			var replica:Zbox3ReplicaStarling=new Zbox3ReplicaStarling(root);
			space=new Zspace3(replica);		
			space.look(0,0,stage.stageWidth,stage.stageHeight);
			
			left=new Zbox3Container(space);
			right=new Zbox3Container(space);
			left.zbox.move(-stage.stageWidth/3.8,0);
			right.zbox.move(stage.stageWidth/3.8,0);
		}
		
		public function showTreeLeft(data:ZintBuffer,sdk:MassCoderA4):void{
			leftTreeView=new MassTree3(left.zbox,sdk);
			leftTreeView.fromBytes(data)
			leftTreeView.ss.display(stage.stageWidth,stage.stageHeight);
			left.zbox.width=leftTreeView.ss.dragWidth;
			left.zbox.height=leftTreeView.ss.dragHeight;
//			left.zbox.scaleLocal=leftTreeView.ss.scale;
			
			leftTreeView.tunnel=hub;
			
			checkConnect();
		}
		
		public function showTreeRight(data:ZintBuffer,sdk:MassCoderA4):void{
			rightTreeView=new MassTree3(right.zbox,sdk);
			rightTreeView.fromBytes(data);
			rightTreeView.ss.display(stage.stageWidth,stage.stageHeight);
			right.zbox.width=rightTreeView.ss.dragWidth;
			right.zbox.height=rightTreeView.ss.dragHeight;
			right.zbox.scaleLocal=rightTreeView.ss.scale;
			
			hub.dest=rightTreeView;
			
			checkConnect();
		}
		
		public function checkConnect():void{
			if(leftTreeView!=null && rightTreeView!=null){
//				leftTreeView.receiver=rightTreeView;
//				rightTreeView.receiver=leftTreeView;
			}
		}
	}
}